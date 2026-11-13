Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.12.199.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567788;
	b=BJVhJb4tIhXC8AL+ALgwZCus2KhBDIzNP5011xaYroZ7JceWOdLwhm/tuQJwhIK8Wl2B
	 hk+ggWEi7MG7wycZpI5hiLIjixI6fSr+ANSfnQi41kp9TgfBdFLWubNFiFUQl9pP/VBFI
	 L8pvN1WB9asuu12eSgux8d02NWUD0pbGPBR9VY5aK74IlYXOyVD/KyNVgiVVRtxmwILxh
	 adj1rUFBXg8e04ht0A0jSBopid3vNUevDUPvHuAMZvsJyAUymGf+MhmqcmSUcbXt84G+N
	 Ave0foGJXpvn+op34IvkCmrWuA8LY0TpPlquR69a74uK5GdqtrMBGZSXtfQl2dsWC1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567788;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=TF0d1i8iIVpJF8ntw0uYDMU0Ege7WR8OSZLCcU/WZq0=;
	b=Ii51fs2NEyOvPFkoAEsHNMaHmM/6Ai8bCsdqX02LD5M+9ZwmDURzCVXo63t9Heqc2ChR
	 FvaBT24ngUtKi8YpyAZiWbPEoc3TXxJdyj2GpBLI3PxOrJTMZlCRdGSy422ZsZ7Vsm7UC
	 IAUO3WTERriyu6S3iRljDNaQelW3/rU8pW4NXgyFXUh2VIkA4FBNl5MmUdNs1FR0/Wtjp
	 Ur62FvxQJgIWsWQqTs/y6fOypahWJvXIvelOMHCRg1J06+FIFpgxyeGIjdfynBG/kooJc
	 FRwaU3Rtl6yf/f1uvI0msbdMbLPVGAYvEGGVc9UmDuKALoEWFl+rZV5yvxppLRj0V7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=monom.org;
	spf=pass smtp.mailfrom=monom.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=ulyDssWL;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=lukz+5yH;
	arc=none smtp.remote-ip=49.12.199.46
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA6606B261
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 11:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0CA6606B261
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=ulyDssWL;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=lukz+5yH
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1794567765; bh=TF0d1i8iIVpJF8ntw0uYDMU
	0Ege7WR8OSZLCcU/WZq0=; b=ulyDssWLMzd24kIHbM8kH/XMGZ/RZ1xaE+UNjJaPJwbRzjSG8w
	Znr6QsFzvuDRs7FHvWNG3e4upwZiP/h5ULAQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1794567765; bh=TF0d1i8iIVpJF8ntw0uYDMU
	0Ege7WR8OSZLCcU/WZq0=; b=lukz+5yH0RVntm+2aqoO44i/qEZXOCQN+psVJnbxsP6ADDnK5e
	qF0uYn8Tx0SbgPHZb9/0NstkOc3Icd3r6oUCYEFhLJyVt/V25l+5GV7r0iR7N4GsMHhRACX9RL7
	0r/wk/NLn4upd/mW6DHN4VxIkn21xQk88MSszo9dc4bJGXs/mhFas27UBEYeQYzU0DIy0ZWwmfh
	RydeDR4Py06H1WCTTKxAH6SYKy+OIPjiRAZL66MrOFA76j0hUhcLiJaZOjVXYxJbhEqw6ZGPvNW
	gTZQAvbnVTsXQDoPgVxV9Ktaf7MmNxrc94eM7YwpIgq3EhbyMD5IC6mmudbTToyWbGw==;
Date: Fri, 13 Nov 2026 12:02:45 +0100
From: Daniel Wagner <wagi@monom.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] rtla/timerlat: Lock the memory of the user-space threads
Message-ID: <4dc4d513-f632-4c1a-a866-51143424c409@monom.org>
References: <20261112-rtla-mlock-v1-1-418986711b20@monom.org>
 <CAP4=nvRQE+GKPT1-KgZ4OgcVV7eKqnkURaELutSMgK4T8YAZMg@mail.gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP4=nvRQE+GKPT1-KgZ4OgcVV7eKqnkURaELutSMgK4T8YAZMg@mail.gmail.com>

On Fri, Nov 13, 2026 at 10:30:33AM +0100, Tomas Glozar wrote:
> > Lock the user-space threads' memory before they start measuring, as
> > cyclictest -m does.
> >
> 
> Thank you for measuring this.

FWIW, I am updating/improving my homelab which involves my RT test
setup. I only have older and smaller HW hooked up in my lab. The switch
to rtla and using stress-ng was on the TODO list. stress-ng has a bunch
of stressors which exhaust memory or CPU time. You might be able to
reproduce this as well and bigger machines. Let me know if you want some
tips.

Cheers,
Daniel
