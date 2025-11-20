Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70582D9ECF;
	Thu, 20 Nov 2025 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763682017; cv=none; b=D02H/CzshZng92fYmqYytTjmEaYiHxNSd2UX6p71eHYP1mSmAbQvSprRwPA5Hv4Qu61coXCrrTZpV+pkxRRKXoUIp5/zDyM1+7ZGn+WuYmzpacWylzu8bDr0IyVKxFRteTbYjLrUuKgoUKdcn0qrrJE5kYiL2cd+pJwAfIcK7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763682017; c=relaxed/simple;
	bh=JG9f1OjBMdf7yoOa5RJb71QqX4LxDSRoG5Wti7Y7BPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIWP0CH7D7xxBSj7GXz/rHKPn30Q72O0oSoZ+tE237wHgAVoXFga1DlgLJGg5QKOqTYs3LRX97iRHujuR9RTGZNXE0PbfpkzxChV1ChDTOkwkJrIj4b97xD9FD975oxt4JoVFqJpcbZkEFc6JijkvQm8d4Ra2sFSHQOygPoFjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EdOaD6sg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EdOaD6sg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=WN4hrWPH4FfMm/ZVCXvvhwCBg/LsIKFQt6elBO3Eqj0=; b=EdOaD6sgC0luvby4gyYHGR21yY
	b1kOrofRQQ3o+blU2SxAQU3WwrLdvsLAtjL6cYHEuFxo6aEfoRI2WZAqJhWrOyjuMbggEi1D1Jw/e
	UI0Qnzfp1HAleyEsv78CEHRoI+/dCRFLmJoAsjc7aPbgiYR3GJkRhn1DW0NpEfY1dHNSDXqm4E/zp
	mcUaNMVc8b3WkhHlh31mpXCE5KZbo0MKEOmt8nJ355/Hhl4rk0LOTNabtsNBNZeO34iHQT3Y7PCKX
	mqTQbJVeyTLNEcuwu7ufAolMQ2gMAlohMRQP1gpyoi5VXC4Wc4v5Lvfs0JTJ0y0p3bqoReFtzKSXz
	72dNEOPQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMEG5-00000007a4q-1G1q;
	Thu, 20 Nov 2025 23:40:13 +0000
Message-ID: <4bdf9958-5d57-41fc-8db3-c7e793a1a234@infradead.org>
Date: Thu, 20 Nov 2025 15:40:12 -0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Documentation: Add some hardware hints for real-time
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20251120113708.83671-1-bigeasy@linutronix.de>
 <20251120113708.83671-2-bigeasy@linutronix.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251120113708.83671-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/20/25 3:37 AM, Sebastian Andrzej Siewior wrote:
> +Hardware busses
> +---------------

s/busses/buses/ as in paragraph 1 of the text...

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
