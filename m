Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0F5172C2
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907821; cv=none; b=gyjVlsx7hK+zs+GaX5gZmUOwhca91MtJsFw9lPCEeDvVBtDpRCAGV/cLwwCOoijBZvTREWq0oU3A99cSNds7OW96tjRYckVYLKuKCIlloGDITz05qbv5mufeHY5LdJqp4G9tElTUyNd2e7ZiCm2OpaGB7e7Wq2zYKELK1Wd/nJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907821; c=relaxed/simple;
	bh=fks/i7WxKGfFbSzPs0Dn6V9gsVh81yib0Olu1oFHYuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln1YM056b/NgMYhhiF8vDZGx+j64NOjSYKsam3UpECnQUABZ07l/jXo8xhTVBPoWI2kKjjFJn5CBehdy/0qhF2wE4XZiczStm5W31ypcvO7YxiPKNsPbtXdP5KDyNCZQQKdiVGAWoFVMWGBlHYTcLoYZwn+JnJtwnVsoh1tnD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q2thVAC8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xMzGA8yo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q2thVAC8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xMzGA8yo"
Date: Tue, 13 Oct 2026 18:10:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791907818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7H//URhXC0oul1iFt5/8Y6v7PHCm6PR74pGisVC0i4=;
	b=Q2thVAC8GiGtj2OoRBcrwLByY4CmGASkuDfNdaD9fRtoB9HocGU3/SFMJjBTfQoA209saa
	nvop2qXJ3RmPiblZTdJYct7eVU91djoCb0EM15KVmL+6fRHEjXjKxlpqaZ142k7hcWW+0z
	JSRiR9OMDV1f7Df+wPqaixYBmkmSUIte8oMCZq8tJCZdINcmgjI3+jsYs4buAl8OwHBW8X
	/siNWx7DyQgeDn5qHGowo0WVT9w/eHOwaTB89daKUfSsLH1Dufj5BwVsLwyZcajTtwEoRe
	NFGLcda8vV04nA1VVIzs1eaIBFPtYrDAhLB5Dr9H2gMMS6I2N+xAmCAKj+i99w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791907818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7H//URhXC0oul1iFt5/8Y6v7PHCm6PR74pGisVC0i4=;
	b=xMzGA8yoWuC/gLMveMgfwQAEvF4+WQQtfdQBjJ/i9RhOWrJ5kdQJb8jDVbz9JR8HbSTRnf
	6OqSSSoUtuGz7NDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Bradley Morgan <brads@mainlining.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: Re: [PATCH v6] softirq: Preserve interrupt context during IRQ exit
Message-ID: <20261013161016.GXeRYKQM@linutronix.de>
References: <20261011060742.30584-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261011060742.30584-1-kmehltretter@gmail.com>

On 2026-10-11 08:07:42 [+0200], Karl Mehltretter wrote:
=E2=80=A6
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20260813130826.GW687043@noisy.programming=
=2Ekicks-ass.net
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>=20
> Changes in v6:
> - Keep HARDIRQ_OFFSET through tick_irq_exit() and use
>   hardirq_count() =3D=3D HARDIRQ_OFFSET for its nesting check (Frederic).
> - Update entry.rst to document NOHZ handling before the final
>   preemption-count decrement.
> - Test in_hardirq() directly in softirq_handle_begin() (Frederic).
> - Drop the in_nmi() test from the timer thread wakeup condition
>   (Frederic). NMI entry adds HARDIRQ_OFFSET, so the equality check
>   excludes IRQs nested in an NMI.

The NMI check is from
	https://lore.kernel.org/all/20221208075604.811710-1-junxiao.chang@intel.co=
m/

and it seems it that it has not been required.

> - Drop the earlier Reviewed-by tags pending reconfirmation of the
>   tick_irq_exit() behavior change.

I checked v5=E2=80=A6v6 and it looks okay. The other bits I already looked =
at.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
