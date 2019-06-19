const axios = require('axios');

export default {
  name: 'board-register',
  components: {},
  props: [],
  data () {
    return {
      freeboard_title : '',
      freeboard_content : ''
    }
  },
  computed: {

  },
  mounted () {

  },
  methods: {
    //게시판 글 등록하는 함수!!!!
    registerClick : function() {
      console.log(this.freeboard_title);
      console.log(this.freeboard_content);
      axios.post('http://192.168.1.125:8080/freeBoard',{
        freeboard_user_uid : 1,
        freeboard_title : this.freeboard_title,
        freeboard_content: this.freeboard_content


      }).then(response => {
        if(response.data){
          alert('게시판등록 성공!');

        } else{
          alert('게시판등록 실패!')
        }
      }).then(this.$router.push('/board')
     )
    }

  }
}
