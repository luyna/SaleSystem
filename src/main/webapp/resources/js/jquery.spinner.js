/* ==============================================================================
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
;(function ($) {
  $.fn.spinner = function (opts) {
    return this.each(function () {
      var $cartNumOnly=$(this).parent().parent().children("#cartNumOnly");
      //alert($cartNumOnly.attr("value"));
      var defaults = {value:1, min:0};
      if($cartNumOnly.length>0)  defaults={value:$cartNumOnly.attr("value"),min:0};
      
      var options = $.extend(defaults, opts)
      var keyCodes = {up:38, down:40}
      var container = $('<div style="display:inline-block;"></div>')
      container.addClass('spinner')
      var textField = $(this).addClass('value').attr('maxlength', '2').val(options.value)
        .bind('keyup paste change', function (e) {
          var field = $(this)
          if (e.keyCode == keyCodes.up) changeValue(1)
          else if (e.keyCode == keyCodes.down) changeValue(-1)
          else if (getValue(field) != container.data('lastValidValue')) validateAndTrigger(field)
        })
      textField.wrap(container)

      var increaseButton = $('<button class="increase">+</button>').click(function () { var $cart=$(this).parent().parents("#cartNumOnly");var value=$cart.attr("value");$cart.attr("value",parseInt(value)+1);changeValue(1) })
      var decreaseButton = $('<button class="decrease">-</button>').click(function () { var $cart=$(this).parent().parents("#cartNumOnly");var value=$cart.attr("value");$cart.attr("value",parseInt(value)-1);changeValue(-1) })

      validate(textField)
      container.data('lastValidValue', options.value)
      textField.before(decreaseButton)
      textField.after(increaseButton)

      function changeValue(delta) {
        textField.val(getValue() + delta)
        validateAndTrigger(textField)
      }

      function validateAndTrigger(field) {
        clearTimeout(container.data('timeout'))
        var value = validate(field)
        if (!isInvalid(value)) {
          textField.trigger('update', [field, value])
        }
      }

      function validate(field) {
        var value = getValue()
        if (value <= options.min) decreaseButton.attr('disabled', 'disabled')
        else decreaseButton.removeAttr('disabled')
        field.toggleClass('invalid', isInvalid(value)).toggleClass('passive', value === 0)

        if (isInvalid(value)) {
          var timeout = setTimeout(function () {
            textField.val(container.data('lastValidValue'))
            validate(field)
          }, 500)
          container.data('timeout', timeout)
        } else {
          container.data('lastValidValue', value)
        }
        return value
      }

      function isInvalid(value) { return isNaN(+value) || value < options.min; }

      function getValue(field) {
        field = field || textField;
        return parseInt(field.val() || 0, 10)
      }
    })
  }
})(jQuery)
