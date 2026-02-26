Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3251396D28
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113574; cv=none; b=O+phkOrItpCV7GhfYqgubfiwf42FdovxSQc9CAAb+VQEDHkIOTK7dp21CGQ8fQyhYCS0rb8C//+wPY9zUIJqdo8x3d12Gy9W6mkFqadelnkIl2dEHXXRVOmP9WZ5SPDepWtK9i4r24kZPr1o7c5BG34WFxFJ4TDyMqy0DT3W9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113574; c=relaxed/simple;
	bh=459YXV58/Cj4pjKqk/E4OrC2EssgZpoRUInlZSMHGL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlM5Ns8i8oyS1BcaYXeMniPaoWVkflwuz8frYhqEAsvqH0xsp3oOGKGZUuYqnH5nyCm4a9ENrwFNl53VRRgxtFcYuyrJyJA6Lw8y37aSn3TLLF3zbNTPTO08Q1lbELDG1dxJJzABNX2n16ZUKHymydLsLGOuEl4PE5n4wB8sLwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ilRRewHp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S9aUqK32; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ilRRewHp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S9aUqK32"
Date: Thu, 26 Feb 2026 14:46:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772113569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3CqRw3s4kq4lo2ydCpW3e6CO3YwVlw6+na+7Zk+vKw=;
	b=ilRRewHpaIJWRFEKyimW8/NpBUi6EC6cUEA8IxjPFWbL/wncCXVm4PMmE+SJixqr6wLJfD
	6t+TNAaWM0Md+8IyKtQctYnPcBOWws/ruqVtUilzZWc9mPXOhqc6NVdPdJPmx7VjTKkG/H
	kX3ceWTnSz5S+Lej8kyd/nw0pxW5FmpWxZ+0cf6qvpLsiFBrGaC26LwKlMgyRRuDZ6QyV/
	NTPYh74cSaZlvlp89LBB6yM4A5++7iftW+JoXgDN5JBa934ZfdaqT6DddJVKLMw7rsg4Q/
	o6Q09BILJI6RqaZqQhIUq4LJ0dbVhsFPDYtxdWL1Hb2ZbqYfWjBiMqsmIP7agA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772113569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3CqRw3s4kq4lo2ydCpW3e6CO3YwVlw6+na+7Zk+vKw=;
	b=S9aUqK32bf7fFmrFwZIIQ3kayshWHD5AN4jH6aJw0Jg0a4atWFDv/XWDTfA4qe/sTFkNQU
	Ot36Z0DFfCc6KtAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	calvin@wbinvd.org, dschatzberg@meta.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
Message-ID: <20260226134608.wQgP1595@linutronix.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <20260219164648.3014-1-spasswolf@web.de>
 <20260225154341.32AjXoVi@linutronix.de>
 <6abee0b4bca811680a7f7fb6ab70bf27c6805cf5.camel@web.de>
 <20260225165954.180aRkaV@linutronix.de>
 <20260225223135.vjfaFo0c@linutronix.de>
 <b5a3f7a9e83e19209b1bd054e8bd8dfff0d22317.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b5a3f7a9e83e19209b1bd054e8bd8dfff0d22317.camel@web.de>

On 2026-02-26 14:24:34 [+0100], Bert Karwatzki wrote:
> I think I've found the reason for the stall. I was looking at commit 9311=
e6c29b34
> ("cgroup: Fix sleeping from invalid context warning on PREEMPT_RT"),
> and noticed this:
=E2=80=A6
I did say that removing LAZY "fixes" it in
	https://lore.kernel.org/all/20260225154341.32AjXoVi@linutronix.de/

I wouldn't describe this as a reason.
The delay leads to different behaviour and I am not sure if systemd
behaves wrongly or if there is a missing wake up.
Tejun did explain in
	https://lore.kernel.org/all/aQzg9kcnCsdRQiB4@slm.duckdns.org/

that a slight delay is okay. Something is odd here.

> and this seems to have fixes the issue for me. (Five successful reboots
> in a row, needs more testing).

> Bert Karwatzki

Sebastian
