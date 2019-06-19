const axios = require('axios');

export default {
  name: 'board',
  components: {},
  props: [],
  data () {
    return {

      title: "",
      freeboard: []

    }
  },
  computed: {
    filtered: function () {
      var ctitle = this.title.trim();

      return this.freeboard.filter(function (item, index) {
        if (item.freeboard_title.indexOf(ctitle) > -1) {
          return true;
        }
      });
    }

  },
  mounted () {
    this.getList();

  },
  created(){
    setTimeout(() => {
      this.getList()
    } , 1500)



  },

  methods: {
    searchTarget: function (e) {
      this.title = e.target.value;
      console.log(this.title);
      console.log(e.target.value);

    },
    getList : function() {
      axios.get('http://192.168.1.125:8080/freeBoards').then(response => {
          this.freeboard = response.data;
          console.log(this.freeboard);

      })
    },

    //번호찾기
    detailBoard : function(boardNo) {
      console.log(boardNo);
     this.$store.state.number = boardNo;
     this.$router.push('/board_detail')



    }

  }
}
