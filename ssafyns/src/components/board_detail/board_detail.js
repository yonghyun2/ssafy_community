const axios = require('axios');

export default {
  name: 'board-detail',
  components: {},
  props: [],
  data () {
    return {
      detailFreeboad : {},
      detailNo : this.$store.state.number
    }
  },
  computed: {

  },
  mounted : {

  },
  created() {
    this.getDetail();
  },
  methods : {
    getDetail : function() {
      axios.get('http://192.168.1.125:8080/freeBoard/'+this.detailNo).then(response => {
        this.detailFreeboad = response.data;
      })



    }
  }

}

