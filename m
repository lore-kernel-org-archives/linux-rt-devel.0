Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFB04C77D3
	for <linux-rt-devel@lists.linux.dev>; Fri,  5 Jun 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780656336; cv=none; b=TyIa+eVwmgb7PcZosITqA0kl+L+OhxB4zVf2/17bVyZCKxzVFM4A/lFq1MK2TwsdCJbVIyZEG2M9NdSLjtwzZ8SAuSydM3ZUQG4gcXjGAeaN3cCiqUSLMk/o35DX32JT7JacpYeSYwTZL0cjY2X4WTizmRuwKxqn2DUVWgLOhCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780656336; c=relaxed/simple;
	bh=c2PKS1XW10wkafeF0Vt32lyjnrOfMLlC5d47nOHxxjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prty5X/GfSSwUAB0FcRCvhz2IOvMQIPQbCrrOOY8KGK0HnP5Qy/64JUVlI+URf5yV3Ko+YmE/jT7C2/2TqpFicyv1MoMSwq+mJrTrLX6vStQqk8VZ7UYUx8TfUIWMpBth9nt+OmBo9SMGL6Eh7boUEWOAhpgb5hLI3DnWC9bzzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xiRLXfX4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7fQSpUm6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xiRLXfX4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7fQSpUm6"
Date: Fri, 5 Jun 2026 12:45:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780656331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LF9yt+p04BquGQG0MmZssRiEKf6n47CAWgbzRxQjuak=;
	b=xiRLXfX4jztnbfL+V4MgNFZgm1X7vb8AWk2nY05svbNk3cs5n9ocs6ZZW9uz2BWgW1SSBc
	J3JMGuCsjuHLa+e9Ppwd8aXnazMVSmEiQ2GbRRjj2rBUWlVDo+jegGaWWBXVhX4NTkEBAZ
	jYgdTPRwgm5zdcuuojliMw7mRpMZQJettJc8s3833KOGPmQDKddVy4ItGKpXiro4oTRhAB
	2OmwbjqrkZS6skr90Vf3hCcm1ERVe10oDha1rVMGoUweDHolyLiCkl9ThN5pxjM/34QeW2
	SXtHJsiXOSsG64OncJAZ/MKkqr6uAUn/hOA2SKL9J9qbFhkKrshFM4CFJPUg8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780656331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LF9yt+p04BquGQG0MmZssRiEKf6n47CAWgbzRxQjuak=;
	b=7fQSpUm6UBBsiU6BbltD1s/YZizdKBXb2ANhohwkFNNvbg/wAqFSsl1KVJPTm3jBhV379I
	v3J3lwzs5MExw3DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Henry Chen <chenx97@aosc.io>, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v2] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260605104530.LDbF5MDD@linutronix.de>
References: <20260330073234.303732-1-jiayuan.chen@linux.dev>
 <20260402065015.JKszGSXu@linutronix.de>
 <52db48708d5a7fbcd146745c4288e567424c909a.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52db48708d5a7fbcd146745c4288e567424c909a.camel@xry111.site>

On 2026-06-05 18:31:41 [+0800], Xi Ruoyao wrote:
> Hi,
> 
> This commit significantly slows down execve() (and perhaps other things)
> on MIPS.  A very simple program:

This is probably originating from sched_mm_cid_exit(). Can you check?

Sebastian
