var change1 = function() {
	$("#output1").text(sepal_length.getValue());
};

var change2 = function() {
	$("#output2").text(sepal_width.getValue());
};

var change3 = function() {
	$("#output3").text(petal_length.getValue());
};

var change4 = function() {
	$("#output4").text(petal_width.getValue());
};

var sepal_length = $('#sepal_length').slider()
					.on('slide', change1)
					.data('slider');

var sepal_width = $('#sepal_width').slider()
					.on('slide', change2)
					.data('slider');

var petal_length = $('#petal_length').slider()
					.on('slide', change3)
					.data('slider');

var petal_width = $('#petal_width').slider()
					.on('slide', change4)
                    .data('slider');
                    
$(function() {
    $('#output1').text($('#sepal_length').attr("data-slider-value"));
    $('#output2').text($('#sepal_width').attr("data-slider-value"));
    $('#output3').text($('#petal_length').attr("data-slider-value"));
    $('#output4').text($('#petal_width').attr("data-slider-value"));
});