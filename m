Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF3D3E0227
	for <linux-rt-devel@lists.linux.dev>; Thu, 25 Jun 2026 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389305; cv=none; b=CDxXRbZrWioFCT36yNSgSexNR7ViMvlEdYRJHCScJTpWc903wPrE6KcnYIPVm9jS3aiGcut7CQKDe/GkYx787y6qge3i4o6oSGjSQR153JX5w8M9VtyTwjHR5XepoVb3EGOQM3/P/3EzoI/j9RmRc/3HCl5ZUUNvjJMOvnPZi5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389305; c=relaxed/simple;
	bh=rnC19SJIB8IwjPpZjyOW9vAFG81ZtsEUSHRdP82RYv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeZDJcopslq+AOdMXwqx9UCic92hoZQiC3kPELDpCAMyTeEPaqTZt5fR8RMMajq64O6kMESTIBjoncmFi17yWLAJvQ6dviZdYPzNv/UiM8/v2oWGDeJGQNhu9p7xwbvTGtL72b8mSA/maO3MW9lvLlYlsbBLrIwnV4S6Vkp+YUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hZWj1sxv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NNthX3RL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hZWj1sxv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NNthX3RL"
Date: Thu, 25 Jun 2026 14:08:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782389301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnC19SJIB8IwjPpZjyOW9vAFG81ZtsEUSHRdP82RYv4=;
	b=hZWj1sxvXAx2kbIij7hPOANuGEApe9ROSVloikyhvbWue0ENgZXJP0wx9pYQCc7L3CWPL2
	azZsEGY8Kq4xT+YfwPi6Uj7b18Z0+b9F4uy/tjceDqTgKW2Sbj1EtzxEhPDU6N9M+Qan7R
	95Xq89RMt1ksBDn8S0FrBlGRHj1tsbl0G0q0kXlBofs0wzzwZHwx5nT4kK8ee1oj55LMb4
	bZYvX3RfnrjhMJsttIQ8i+4ZGo4GdUGB49YAb6dEEAKTUpU8bmKGKqzVe41cGgKXzmw1ec
	YxKTCLcV9k9wHDF++loCqt5YMfACC48XySlqNiYUtAPuAI2tffl2sz5y2TlJCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782389301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnC19SJIB8IwjPpZjyOW9vAFG81ZtsEUSHRdP82RYv4=;
	b=NNthX3RLO/2AwrFk7DPc9eyAGWhbPpJ8XQgDtdhk4wHM9jdyiePonsiFcXkG/66zDdTtDk
	sPSHQv6K0tRz8RBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, clrkwllms@kernel.org,
	rostedt@goodmis.org, linusw@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, liaohua4@huawei.com,
	lilinjie8@huawei.com
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling
 user mode errors
Message-ID: <20260625120819.K5e1OVeG@linutronix.de>
References: <20260625073522.182503-1-xieyuanbin1@huawei.com>
 <20260625085034.tvyGSmaP@linutronix.de>
 <ajzvcCve4LubjH9J@shell.armlinux.org.uk>
 <20260625093008.e5I4bh-_@linutronix.de>
 <aj0A3SjMhR24e8fP@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aj0A3SjMhR24e8fP@shell.armlinux.org.uk>

On 2026-06-25 11:20:13 [+0100], Russell King wrote:
> > is not worth doing it? With this I can my little testcase working.
>=20
> No, it isn't, because if you enable PERF_EVENTS then BKPT breaks.
> hw_breakpoint.c claims this vector.

I see.

=E2=80=A6
> BKPT is a total mess.

Understood.

> > it does cond_local_irq_enable() which enables the interrupts if they
> > were enabled by the "caller", sends the signal (SIGTRAP).
>=20
> I'm happy with that approach as far as interrupts go, but we can't
> change the behaviour for FSR=3D2 again, beyond fixing LinusW's
> commit (which has recently been reported as a regression.)
>=20
> Note that the change which makes this raise a SIGTRAP rather than
> SIGBUS when PERF_EVENTS=3Dy could _also_ be reported as a regression
> that we would have to fix, and making FSR=3D2 raise a SIGTRAP now
> could very well invite that regression to be reported.
>=20
> Essentially, I don't think we can "fix" BKPT to always raise SIGTRAP.
> The BKPT instruction is something the kernel has never _officially_
> supported.

It looked like an easy fix. You explained that it is a bigger mess with
"other features" and so on. Given that and the fact that it was never
supported, I would appreciate just to enable interrupts before the
(SIGBUS) signal is sent.

Sebastian
