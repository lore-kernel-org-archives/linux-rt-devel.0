Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BF0360EDA
	for <linux-rt-devel@lists.linux.dev>; Thu, 21 May 2026 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364881; cv=pass; b=NdOEMQSwXj2YKqm2wh3PX2FzzOEuyyhpZcwibQbu+2Z8vSYZXbwDGZob7sk+wo6/1gJRJpold/PazwrQBV+HJsb2eDaX7kTBRg0VhzpGQzrrDT1cGGXYYQs8KnlaNBsIMMQjhiXrITEej2qWV3ApvCcHodzhE77xszDqSH8i0Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364881; c=relaxed/simple;
	bh=N0WRCQ+KH01CpayEYyy7mrrqhMaV2Yzdg1bxdqWZuZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M503cVtXybUhe4z0wo0SnmN8ilpDrz0Q1jjKkzohT6jegSLGLIeIG02bb2hoT830+6ZyvKy9U4FPIMnxjT7EEQuvQe9P0BF/QHIMor2p1rzbcHdCl/Ob8kRER/9o24rpdTMSXnGDeGFscKlgL6jrK4sAukBRlX3uqOkWOIyNlMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sADG85cB; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sADG85cB"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd3eb594960so731524566b.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 21 May 2026 05:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779364879; cv=none;
        d=google.com; s=arc-20240605;
        b=K5AV+BA2HoyYpPOoA0HxQ9vyognV26PZ9DgFByqQLhFobyTUjztC3upY3Z5dUhVxUv
         gho6n1CmjyDkFGA1/4GhlaAXN2CMVmqytjQbSOipXKEtnHgTap+B2wOYcQ0XehTx8JSl
         +9r59wvdkkxq0ubKBDbKvWKPq9ujgO+IUE5ohYWohwQSjCwYckpkCfNKK4KdlKcgKrOn
         /5/JOZl5Ob5qJ2BI0qPp20IkMOdJ35JDMJ/tzMXnWVaImAUXyR3CJIWj1JMOyNKYtUMi
         lKFWZ2RUtw6/MqrWPwEzJjyebr2R/F0yE205INOmOM8+p4d0RjiavRXFlZx1P3QrfOyv
         B2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N0WRCQ+KH01CpayEYyy7mrrqhMaV2Yzdg1bxdqWZuZw=;
        fh=8u4dKd3Uxio/kBHB04HUSnkDBBDciz3SVK0Qep6UMDM=;
        b=UhtoJ0CcGSvYLzmhrsXpWpT58eTxurtd329PsA4tXgZN47NTFAPFbVKVNbbbmmN04g
         EWAXHuLZfgXryI6/cc5dLRL0VbzMbMq/MZB2SmajmLGy+4m1XcqU1GkyDdD5fNDYUhhh
         vVi36FBuSEFf+qezp7CqtuFAncDwk1czSOpNpBB5ENVzGWPn6t4XmwHdqEuLlZ1ObekO
         YCmvJJs6C9h6mFzXUwdY1G40PrW9M7h0mn3gR+aT/uONXHZl8+/feWrTpaFf3v8Ld7Ep
         7C7hbhmnLLL1rLbZB3q4JNZdLP9RGkAVsRFkBoUqK4pmi2A3MleQYMDOWrEK73R4e//b
         FtHQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779364879; x=1779969679; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0WRCQ+KH01CpayEYyy7mrrqhMaV2Yzdg1bxdqWZuZw=;
        b=sADG85cB4uxcWDWCQ5GEtetUAIaUp1Q5d6m+j3ZsSHg8+msvD8xxbTgeAKzf32BV1c
         W1wSVAzIhkkaI4gtx0SBakbhusJwc8mulAfxGOqfMZ+ki/WaXv4AG9eRHk7CkdTgQduI
         GD/ZQCjzaoSUsrMCxU6p1qKvXqWVxRPjkdphzAr4gztrB6UFCo8QAjk9OtVq2GZt1haa
         5CYrO1IUwscK4Doq3kwmpUplni6F7lcycDW+E4IeZH9SaB1BPTVeEzbgCd9ELhXC0MEu
         XsLUMU7BT+1Rv63WM+1SIzY6WYE58dyEQ0yQ19QQP2ek72mc7Z7GBf/mrEKXe4uYpxNA
         4pDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779364879; x=1779969679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N0WRCQ+KH01CpayEYyy7mrrqhMaV2Yzdg1bxdqWZuZw=;
        b=FoMCP9r3K0hz48ORNsR0t/a+5hgRYbVY9AZN+32XI2nrVCiSvAPRq1ws0HhmN4vkzu
         2fuZsAvDPUr1iY2YJpy11VGW/xe8WuRwwYQ8Zo5nC29DOipqPlKX+2jhxIEXYnkfQ4ty
         6cs/Sh3p+JGLOThdjLe4GC7jrMbzS3lKPVARXwfbNyO4NzYFuWLQQaelMe206isoKZyO
         GtNStQ7cIjudjz7eBGkFoVfZZajGByUoUZJgeGhwqD1YcnKzD7hohcoWqzqZ+x9aKjKt
         E27uH6HY4bhqF2gXbrpdaMMJA7Xx7NwmlSyZD9SjAMtdLjVhcs4R07fitX1nARSCsICT
         +RRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dosls43Tzgm3emu2tKHk7Yn+BylCWIqvGGgEcPIs9sQ8ovT40oMAjGnkc86shaauQ/P7pYqAZs5VsPwb3YA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTEUrrQGx8j06lMe/01HBnDW0LrPiM5hCl0Pyy0De0e4a6jr9R
	mdNEWsWfJycrxxrxAustdyZb3AZNvs12RRRqydO7p8Yki/LTba4aLIjjJhqu6WX/uGnbyPBWFyH
	4rx54Rx4l/YNrq6qbXt4qnrmIuuBa2oA=
X-Gm-Gg: Acq92OFl7edyBPYKnxinZMckQBC0dUA1yb06kGAq1/XRScK8kQ4POFGFb/lUxwcQ/mQ
	fYjUDtNv2rtmlNGFxLe/lfr+QwFWjCRxnkGytnMLXBZXI7jQG8AGpo//++qLLssZNqR4c6iS40W
	y2znAlY7oD1d8dPxRF6ChaYA8FBtQsVviTLh6gRyp6BvrADWHogsul3yG6xTotqYp9CNiCjJQDZ
	qkTIkhXx94wobm1mMlh4Iqu/y+IF/3XkqFD//ANIOylhb9KI7wZhVfCVncjkoSJyc0OYDWY7r6O
	YKag8dLm2xrvW0TwPfTRkYjbZ61kaYncoDFq/xo=
X-Received: by 2002:a17:907:2845:b0:bdb:e19d:5257 with SMTP id
 a640c23a62f3a-bdc152607demr109803166b.29.1779364876921; Thu, 21 May 2026
 05:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260520225245.2962-1-spasswolf@web.de> <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de> <878q9dvzh0.ffs@tglx>
 <50e5e76bc13256e3f5b3301e92f159957c3d6762.camel@web.de> <CAGudoHGk1CP3gRQLCV85AFHKx6vBEyKySOn4J+AZVAP2FkrN3g@mail.gmail.com>
 <70676dae700e6a40989315bf31ea269a509ddc0f.camel@web.de>
In-Reply-To: <70676dae700e6a40989315bf31ea269a509ddc0f.camel@web.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 21 May 2026 14:01:04 +0200
X-Gm-Features: AVHnY4Jlf-yrDim2uzOH0TXtokw0U7b4OPXVrImpSSlCPvkxIq7CNbdejhw5Too
Message-ID: <CAGudoHEX=Su_ehV8nNP_6Onfh=hB6uiyTTCojR7nSOkEj6zh4Q@mail.gmail.com>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 1:51=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
>
> >
> > Can you please do the following:
> > 1. go back to the known crashing-tag, add my fix, verify you still get
> > the amd splat and then try out the fix provided by Thomas
> > 2. regardless if the above helps, can you boot a kernel built with
> > CONFIG_KASAN=3Dy
> >
> > fwiw I verified my patch works fine with KASAN, including by
> > intentionally miscalculating the size of the target buffer and seeing
> > a nice splat from it so I'm confident I'm not corrupting anything.
> > However, as there are new mallocs + free flying around at early boot,
> > it is *plausible* amd was getting zeroed memory without asking for it
> > and it worked by accident.
>
> I think the warnning from amdgpu is only displayed with CONFIG_LOCKDEP=3D=
y, so
> your "improved fix" does not silence the warning from amdgpu.
>
> The additional fix from Thomas fixes the amdgpu warning.
>

I just wanted to confirm my patch does not *cause* issues, at worst
uncovers them.

> I also built the kernel with CONFIG_KASAN and get no error messages.
>

nice

I presume Thomas will handle getting the amdgpu patch to the right
people, I think it will be fine to drop all the mailing lists and the
cc's. :-)

So overall I think we are done here.

Thank you for testing and sorry for the breakage.
