Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E7E42CAFB
	for <linux-rt-devel@lists.linux.dev>; Mon, 20 Jul 2026 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582814; cv=none; b=cllIHpR8jRBS7IFIQhhRxQhADikQ7g1cY1bj6QtLI55/eHz7Dpsmsre3qiXPQ7MP6RfvbkB3e3XPsOc2nKBaztsVw8/0Z8X8XZJx/l6owag7CLrtcGrSOaQiN9ppgZL+Ci5STsBFOZCzfl51RSPsPtc+v5AtcZkrrJhf8wsX7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582814; c=relaxed/simple;
	bh=KBb6QIoZw0FdFa7o5VODkCyFlMxQ+46+6ErjuXZUcaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOn0DV3C0bPh3UKeyQt07dFTfjLjYh+XMoxA5aEYUhEDKR4GbFfMoB3o8Zq0/mHolPmlIs3aXdmVLEaHaNPmpAYv0npJBAoDeXb/LqDGGZGtbgmvtsGgHA9SMFkMocuY5xDfDjbDN97e9yP9N9inaHdXcSd8FrYIDnrOJ4nr80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyDxWKaB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyDxWKaB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954afac04bso30335075e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 20 Jul 2026 14:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784582810; x=1785187610; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qyyZwG9uZSyTHP89I/9Uxi2/crj+YVtpDfvIWd9J/1M=;
        b=OyDxWKaBAAHmveEpXXHZAMjkOVgdTdMJouYgmIjYOtgoFfCNXn425jK5SgtXLUCaIp
         uo/pKT/Vf5Tc3WrdwNSKTija2FLRHWFkTikZ8GMnAeGgoQjwB5XjSgfFN18KlVTM/tqc
         6RyerM8758xv7oane0kKWiNhcOGyF8VIlNdFJY+9dIHqAX3lMBkAXae1rx4WCEHnEYA/
         QDQoKOaDxLIJPRjToKYIqzzMMI9A3TTSD/1gW9B4ijxIOmWtH8VbFWZlguea1FdbN0CX
         L4y5RZ2L6wQqRsvx7SUpRcvYxOZPI6J4rxm6gJED3Mj5EzskTm1dVCnveYkuMD17q/hQ
         HVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784582810; x=1785187610;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qyyZwG9uZSyTHP89I/9Uxi2/crj+YVtpDfvIWd9J/1M=;
        b=TnjBDIrFmZYgN2FQTDs7LXO1OqFJsSLqzDuODGpBPzsMwGfveQ1l3TjTSjomqA8ANs
         apgX10YK6XpcStojHoKr431JCB6E4oQiI5cQWSP3ZK3t+1fEv7w3yW7BnZ19vAYlkdxy
         HooPQTmIveroGxoALB2BPySQIz+wW8dtoyHfmXHXNcoptr+vYXg1U5IlQ/zVuq6VofWn
         0O8moVWSsn5W1nmm7Wxx05Cc4utP2kc0oTPhpAMrEqnrcPzgJ4euMxZu+7Aq/Ip0+8cY
         JgXsGc5qNTeQCQzmu/6AEiOwvzsCQ2g1uU2nJziO5Na0FrqWQlljVHNJXvuQze+Lib4y
         +yNA==
X-Forwarded-Encrypted: i=1; AHgh+RpaMBFJ0wxbeUTbxMS7H2/zMxGfO7B/tSChSaeZMuN/XapXEYJHTHd1W2o5j+mrcnbtXqwMMmFp78FaGo96pA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy57RbN9a4i/CH/0chPAYTwYI9VOCunhCMP8djm3pb3rxQXZGuT
	16SaL/L82I1G98ajczf6H4VetKGgTpDFzreprRUBs2nwIpId8T5wqbOEsTtG5ty9
X-Gm-Gg: AfdE7cnwRGInPpjmvCyzDITK1EFyjYziNq9S2NPJb7uGyom4R9xMQhCJE/2oAquInTL
	V0k0S/SkLN2uqR0G+115uj0WrNkq7crK97zZCT2a4LyF7+hu8IQh9KQynkyjW9USp/tmPZZJCNa
	Es7X3OUIw1xHJP9s7OH5BHw1Y43q8qaTNljEER/dtZKqEdQc3lwzF+POxT86s2LiIXZhshMaX7R
	ZDW0HVqOpB9Es4aRzOonQvUHYIM9nhaA6S0MOL9blO3v9fPL+23aAxjEg8XA+ISu97/45Tf3V7e
	wohaZN5nRybPOP9QbJxaRO6l64jbTnRLDuCKpTJhSvfbEMDqmK8J/QK39BTzRfjsgk+nKBikLfw
	IlxZnuQgOmEoTxDFV0OyZ6iPO0cv+EXAtb/7alITO4acYvmSiuOTVWrVll4Yay15qyDyeXtZt0Y
	2lt9U50G7z0zPIn5P8e7tCPu/kx65UHRzNBdmhVAKp/3+9HKqvmCSyyPEddny+oEkH7Vpteovu2
	hYx0l74YJIiaIaJTZdCdeX9CL+Fq10xEZWSPqWvW49a2Xec41v7/+G1smmxK0Fw0phpyiW/KUNg
	6O0hOsxY99PHDmSVLxjFc4Vf
X-Received: by 2002:a05:600c:4f56:b0:495:4dd3:ca97 with SMTP id 5b1f17b1804b1-4954dd3cb28mr155374405e9.29.1784582809607;
        Mon, 20 Jul 2026 14:26:49 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-9c4b-4f01-f5b8-3b3d-3e3d-5e7a.310.pool.telefonica.de. [2a02:3100:9c4b:4f01:f5b8:3b3d:3e3d:5e7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956548321asm15332135e9.12.2026.07.20.14.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:26:48 -0700 (PDT)
Date: Mon, 20 Jul 2026 23:26:46 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, 
	sashiko-reviews@lists.linux.dev, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 2/2] serial: amba-pl011: keep console clock enabled for
 atomic writes
Message-ID: <al6M1gwuWfk2wqwI@gmail.com>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
 <20260719063502.18852-3-kmehltretter@gmail.com>
 <20260719065214.A40521F000E9@smtp.kernel.org>
 <20260720080100.Mk9zZFql@linutronix.de>
 <8733xeaxix.fsf@jogness.linutronix.de>
 <20260720082640.eGsVn61E@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720082640.eGsVn61E@linutronix.de>

On Mon, Jul 20, 2026 at 10:26:40AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-07-20 10:19:58 [+0206], John Ogness wrote:
> > This is what the suspend/resume pm callbacks are for. In this case, it
> > is pl011_suspend() and pl011_resume().
> 
> Perfect so everything is in place except for these two.
> 
> > > There is also this no_console_suspend argument…
> > 
> > Yes, the callbacks need to check @console_suspend_enabled. If false, the
> > clocks obviously must not be disabled.
> 
> good.
> 

All right, I will send a v2 patch for this.

My testing is limited to QEMU, so I cannot test the power impact or
behaviour of real SoCs.

Karl
