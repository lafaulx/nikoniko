import $ from 'jquery';

class Client {
  constructor() {
    let self = this;

    this.$client = $('.Client');
    this.$choice = this.$client.find('.Client-choice');
    this.$submitted = this.$client.find('.Client-submitted');

    this.$choice.on('click', 'button', function() {
      let mood = $(this).data('mood');

      $.ajax({
        url: '/api/moods',
        method: 'POST',
        dataType: 'json',
        data: {
          mood: {
            value: mood
          }
        },
        success: function(mood) {
          self.$choice.addClass('hidden');
          self.$submitted.removeClass('hidden');
        }
      });
    });
  }
}

export default Client;