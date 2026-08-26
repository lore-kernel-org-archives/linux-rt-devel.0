Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3F37A4AF
	for <linux-rt-devel@lists.linux.dev>; Wed, 26 Aug 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732795; cv=none; b=pwVYES+fxe7pM/5TR4IAXRbATm7pdr4wXz2bVq571+ramBAOP/PesRqVH1BPaiNI9ZPz/moRg/1WS7HIPAb9o+aHI2TeR8NOFsd7jgiqcHcmNlVH7+ZT/kGrJmTyXnVbxcQveo1yVxkLkU8VyBjlmE5ShP/SsH+sE6yQESed+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732795; c=relaxed/simple;
	bh=M+WiYVHhBm4Pxqpa98E3ZuUflVuH993aFiYk9Vpyi5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZ8uNd4mtgxRZzKlxy5Ptgl6cQKFFdejkyxW+SCRMxhGUFsxioNgaUZFGpI1yZy90KLAN/ZFGxxyt21+PWoSJ5eHL3l9vv/1U8fCOOLPaG0I3ufEDbrtCk9XFFswLClPxK2LjpibFsmobeLIWtbedUucSybuuQEX18qFitstN/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JAoIb7+E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TcPgpiUZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JAoIb7+E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TcPgpiUZ"
Date: Wed, 26 Aug 2026 10:26:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787732787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSdbRbF1YOyikxX0H4TSinLvi5dMA+9ZIWrevgT2lew=;
	b=JAoIb7+E4NrPgf7YHnhMyvYPI05qrTzMmPsaf2UqLR8lM3nYyF4elqKxb1eDVbK1wJqg+f
	e+S/t0QUDmCjHAbCcaKqRwUEEuWf4q4Iv5HfutJpLyQ0TJsQo3091atCGE17WBH6nqL5u0
	WkiCAuxiMx7C3YmXUvRnMKHvT2Jk1ZEuX7Y0EaUqe80r5DSIpzaCGXXAnMN0Y8xJBJyKOt
	I8vvTsfgGfpMgMPQJVBZr+k5T/J9pxh8O62FF9fVIy6esvSG0i7XLOcfQt6iRqanPiYuXW
	IXzMG8qOHAtewLG6HR2NswRtNx1J+Tb3IsniQRZgU1K/Pz6RT9akmQ7qoHhppQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787732787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSdbRbF1YOyikxX0H4TSinLvi5dMA+9ZIWrevgT2lew=;
	b=TcPgpiUZoP+lRL8ENPKD3baSNJgBnhMUHdm7SZpf3LFvpzCsm4X6iuXZlNUsc+B/mvoPbz
	VqnaD345Wx3rbUDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Liang Hao <haohlliang@gmail.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v6] docs: real-time: mention the hrtimer sleeper HARD path
Message-ID: <20260826082626.Dc0QiAR7@linutronix.de>
References: <20260820144655.22492-1-haohlliang@gmail.com>
 <20260820163858.27984-1-haohlliang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820163858.27984-1-haohlliang@gmail.com>

On 2026-08-21 00:38:58 [+0800], Liang Hao wrote:
> The Timers section documents the PREEMPT_RT softirq default and
> HRTIMER_MODE_HARD, but not the sleeper helper used by userspace sleeps.
> Describe that path, and rename "ktimersd" to "ktimers" to match
> ksoftirqd naming in this document.
> 
> No code or behaviour change.
> 
> Signed-off-by: Liang Hao <haohlliang@gmail.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
