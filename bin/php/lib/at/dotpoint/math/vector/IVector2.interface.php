<?php

interface at_dotpoint_math_vector_IVector2 {
	function get_x();
	function set_x($value);
	function get_y();
	function set_y($value);
	function normalize();
	function length();
}
