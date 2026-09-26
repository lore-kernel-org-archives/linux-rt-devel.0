Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA753E49E9
	for <linux-rt-devel@lists.linux.dev>; Sat, 26 Sep 2026 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436423; cv=none; b=Pzpt8hmxbBxYxFqZx0PAK5atj4uCOXYuMRDPHEJzSqHmr5bZzQ1o1tQkKJbiZFoBLkdyoGpj5ntHZ3wxB+uh9oQ6tjq5FSzu1Y95BKQ8sEHmG23365PeiTrnfGFkjG4QXE52Qsm4+ThF3Fi2dBCYqnBM+lSQOtij8lCaRqMiq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436423; c=relaxed/simple;
	bh=SzmAPhJSqzo5ihS4UY8Iect4WUU/nMW98tnv+6ln0n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijQwwWsJXZDSqTaD/eytC+z5wQQNtICuZ0UMhPQhmC8mi67Y/7R6MzTlPiP9i+GqkwdM6UaR9bcZQEzEvGZ2AMJkMpKyynJLFnGnUAaMUKBo6kNqh3gA7k//+eoA+F1fsRv+mV+dKmocBJiVUuqgcJhdRiRoi8oZsR+7FLwjsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqAjyw5M; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqAjyw5M"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so1733285e9.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 26 Sep 2026 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790436420; x=1791041220; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r93vo6YJEV/n1FD4tzzKSMKvC9BRqIXeipynuzwoWIM=;
        b=EqAjyw5Mx5J2UdwvUZzOxYo9rtyEkzOaSGPZZtJxrwP+DjYnrF/wM72pfq5LKyv/JH
         QMQyOdjKOxXsAMA6v0fcwwcVoaFwaFvnZWb4L9wpyFJAwQpiAaZIuTZsuhjwvj2hkQXG
         485coaGhnLNR4lW4TLS4flAj3XONYeD0aZbFX5zdEp/CvaX0wyxWomHped7W8NH6y+fT
         2FHfYXQ43cwfZuxZhpuRhSIsmaybquUB0JPzCM75z9qSOCFiEsJ6hkGogKje/8ei46Iu
         INqs033O8M1Iup4A4U5hxk+4WtUFCOp9IquMVpQq3b5nKaorz/nw/QvMY+tdMFVD4pJv
         YdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790436420; x=1791041220;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r93vo6YJEV/n1FD4tzzKSMKvC9BRqIXeipynuzwoWIM=;
        b=ChLU15pXPBlmyMM/aVydQA3xDOvroZkCH/nh+u49fd3uU7Z9+t/HPF32n9RKQNrFLz
         ZXR+kDYeN9lPvP9COQNFh0yS3c8zPCd1/L8l0STZdTXdwqzYn1kooweNmrcN4acOnnUy
         CFQNJseqd3zC/GoJvnKoCa+WN1oa7JxKqksaXR6M9CW0p23yVuZH4c21cOfoepC6dBgR
         NX+LSwa5KbpxLp13az6K6yaunupVTXdqPVVXtESISwJPACy7bJHRqB/AecpWJn/abONm
         qY6DP5sY2DuttPUf41Do68BTCppyj2lcTbHe2yzd4g8bdo4lAwmc8PSlM66rHqSNZW0g
         Fhlw==
X-Forwarded-Encrypted: i=1; AKwUvBwKZM+oKHEPhKrwlcEzFpWGBpMXR1GM3dY19INJEQDGsnh1mlTFiTdg1L1LPjYd5D7mnRJs4XewJRD6PWOshw==@lists.linux.dev
X-Gm-Message-State: AFuF++lJR3Z7t5sRoPSg8WyXHTrsaz9d8xt3gKJpuUVUY0wPOZj9Bh14
	0F3YHI+qkjlKKiwuc07XxToaGq6L+cf/73tJYuRtA8AjjyN62jBp/727
X-Gm-Gg: AYBFou0B1tQty4Gw1MjKoXkrAoaBVx07aPskEEq/XJO8Nxzzae4QCr12F9SUJFae4gt
	gXUOGquz14gdQZn+NSrBzdF9TkkJS9oMYCa4p8KHUPznwbuj+XkxvnaIxH6pEfSHfd/D/hVZ48m
	i74zzyN0tPv3qEG6dZisKL0ANmS4U0itux0gTfwJYkOWNpGi+rr9aEIvgM8atGB/QaKeqjOgyjz
	QsKktcbFzCDYtb+v+qkw2OhhPsuwvOMHACB5Jc8ogqWcIaOenX4bbXO3zqkTyVYzxAj/Fw7LIRu
	+4rQpihefLx2QWj3HdbZkbuMKSmTKIa+GDzeWpSnw1HNmyHa5sHL8EaHZhOi+VW2busJzdGdkyf
	UtzTYbGRXMwKky6vx6dIAucCLWHp0fpOfFo1+8RMyxcFclfbcimUkkpXnIdA8FFNu7X938cYPqS
	YnE1L3FEXU7S0bLndQBARzOZTrQepOZI24hV/3eNkHlXI5Dz0uBsQYpagatCrOxPQsXRALf5t3B
	K+BLWGjTjVQGbbIY15cSfF85e897BldI/2eQxicP5zVjMLukB0tMMOeGoD0A0M+C1cIfLBzojdq
	nwpmkv81L7ubuoMTdzmuR0bXB51yFM+cJJ/K7s119aLHcWjuWTeCetIDzDRseF2ZzvqBL6TTUwU
	=
X-Received: by 2002:a05:600c:8b31:b0:49f:fd66:5fec with SMTP id 5b1f17b1804b1-49ffd66616bmr28453225e9.0.1790436419906;
        Sat, 26 Sep 2026 08:26:59 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b162-c701-4960-a998-3de8-2fce.310.pool.telefonica.de. [2a02:3100:b162:c701:4960:a998:3de8:2fce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef5fe71csm94423665e9.2.2026.09.26.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 08:26:59 -0700 (PDT)
Date: Sat, 26 Sep 2026 17:26:58 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, 
	Dmitry Baryshkov <lumag@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Pierre Gondois <pierre.gondois@arm.com>, Radu Rendec <rrendec@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/4] ARM: allocate the cacheinfo early to fix the
 PREEMPT_RT boot warning
Message-ID: <arfjs5kQjQRb_Ep2@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com>
 <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com>

On Mon, Sep 21, 2026 at 12:11:47AM +0100, Linus Walleij wrote:
> > The series applies unchanged to 7.2.6-rc1 and v6.18.
> 
> OK please rebase on v7.3-rc1 because that's what we're working
> on now.
> 
> After posting that I think you can put this into Russell's
> patch tracker.
> https://www.arm.linux.org.uk/developer/patches/

Hi Linus,

Thanks for the guidance. I rebased the series on v7.3-rc1 and
posted that as v2 [1].

And now all four patches are in Russell's tracker:

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9520/1
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9521/1
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9522/1
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9523/1

[1] https://lore.kernel.org/r/20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com/

Karl
