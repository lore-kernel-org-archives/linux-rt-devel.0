Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D0733A6E4
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034225; cv=none; b=H0sSm0ojabo+kNF6qI2HqRNKjeEyGhpE0nvL1I7dk4wWwo8yfB47qQGTN2aSpkvYk/JW3NybDTviiQtw2/qvcvQHnq4VdX/o1j9Dq92l69NTWJ+vCP2E+2CnoRmKTVpCpUmMo/LHhUF6vMDmmhb3OGsPo9TqBr+orvX4HDYIGU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034225; c=relaxed/simple;
	bh=PL8zrNZDhOKUGTHnWVjAa512dk6h2/HHGn3yofU1M8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3UofOcrgK8Mg9fF2XDJ956lAv3GzUaP8V59lm2XWThtWHeYtFHmwiUAlwf//OjmPtOqsF6qm1q768QSVbhp17C7487QKdqSz7i3l+Dgy4tHuZ+bfbaOQXN11RI8ErDy2J3fSfO1r38YKQzhORFqlzYt+1Im4ZkepEUIZNOpN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PLy2aD5j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7eyfU95l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PLy2aD5j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7eyfU95l"
Date: Wed, 25 Feb 2026 16:43:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772034222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PL8zrNZDhOKUGTHnWVjAa512dk6h2/HHGn3yofU1M8o=;
	b=PLy2aD5jhLo6lauef+FyRjuaQVBvrk5W30L8utWQOIOORNfUNxT+FZ3FBPxVEQ8FQ34m14
	eQQnwkd5qtv1D3XPUhGjAn2jUkr7vtEBSVRwUacYld8dz0nbsQlS9ESxnyB9K7kNZ681Q5
	m5rvU9vTa6Va2Qq6gvX5V+HMquPuhVX1T53tcZ9Y5CjW8RtkHOatBtzy8llLw8XaFTGoNS
	Sk3Uq1/UCThgMaPMLvLrznvVwA/H1JaBNqGVGFvUuUZsx7tg75l4h5D6NjvOWPjRDXDfLJ
	ttDl3z2+EsLJqPtbhkC9gFY9GBBY9eMxRzfZQk+w4vD3OQ6doAxVk1I3ENmSzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772034222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PL8zrNZDhOKUGTHnWVjAa512dk6h2/HHGn3yofU1M8o=;
	b=7eyfU95l4CyDleijHGPOu4W3D3qADaGL3NNqCimUUEHry8KZCkwWntzcniGG6p059dorUE
	dpHv0xKNjLvuKLDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	calvin@wbinvd.org, dschatzberg@meta.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
Message-ID: <20260225154341.32AjXoVi@linutronix.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <20260219164648.3014-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260219164648.3014-1-spasswolf@web.de>

On 2026-02-19 17:46:47 [+0100], Bert Karwatzki wrote:
> Since linux v6.19 I noticed that rebooting my MSI Alpha 15 Laptop
> would hang for about ~90s before rebooting. I bisected this (from
> v6.18 to v6.19) and got this as the first bad commit:
> 9311e6c29b34 ("cgroup: Fix sleeping from invalid context warning on PREEM=
PT_RT")
=E2=80=A6

I'm on it. I looks like we free the task after sched_process_wait() but
before it is entirely gone there is a wait() on its pid. Some of them do
come back but one seems to be stuck and I need to figure out which one.
If we get rid of the LAZY then it happens "quick" enough so it works.

> Bert Karwatzki

Sebastian
