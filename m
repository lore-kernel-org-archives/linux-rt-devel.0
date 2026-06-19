Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27FB335BDB
	for <linux-rt-devel@lists.linux.dev>; Fri, 19 Jun 2026 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855007; cv=none; b=MoTWP1Gr67FrEqvXKzzIsmBDxGG0AGweZNO0jYXdgL9z/yCru7NUX35tgHRG+wVYvLVWy7oFD/355QM5fPHPRph0R2Nw75hG7jHy/9hK03sCNFNCkkRg/6y68Lb+PhB967JlwDy/m/8tPtk/c+PjBbVJKpAYq5WMS14mOxXUu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855007; c=relaxed/simple;
	bh=iMrkouWV4Vkl5zyDFKwkEBcCpHxqGEkF4SfZCqIiz6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxcycNRRckQqITxrXRscRxPeaT3Z0tXUA3dLhq/WVGRgExlkBBUwd+gYmNOZWvwVCY+UOnEYfmpD+FP1QFrUTnaxKNXIw99I3xENbH/OfA5TPcyAH/WBRM8tIzkcondeKz0BlBhD4UpPbfIyLRawR2xehj6aBEDUW6kfuGD42PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zSb2XjRC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7KO1kUXw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSb2XjRC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7KO1kUXw"
Date: Fri, 19 Jun 2026 09:43:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781855005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMrkouWV4Vkl5zyDFKwkEBcCpHxqGEkF4SfZCqIiz6c=;
	b=zSb2XjRCgbH/Jvy1eAV3AaNMiMOMOq9MV/+YaZgDCddUMPYIYyC+2+qpKYhPp9Wjb4nY50
	EbB3HkZIhMWa0/rXyfHjs8rySUW5Bx0NabApnV2t37hXdqFlBwrV47aN2kfTS1PdZcUHkh
	4kMepEnFgTC2JCYvF2q/cqimoaHK5wmDutGQuBIchlKHlsV5c5Y2fZjJBSkfOBnmsP7bes
	r5Uh8oXqynz7ckhCW0Dx+HABNhz2LCaGHHjO/Gx83eIX+mJTKpSvixKEGSi8xJluNElNBE
	9nIYMAcrx613bo1pAcd6TkPNz2QZTtA4o4yxy/W9h8RF2bjR4MXI40w/bsL/NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781855005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMrkouWV4Vkl5zyDFKwkEBcCpHxqGEkF4SfZCqIiz6c=;
	b=7KO1kUXwKqKRgLgQiQzVdKOoirGupUKLzI3yJv6pyDAwiJbgAaOXkJ4lmoSlpDdtTJZahB
	3ugjQufabERtVNDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Message-ID: <20260619074323.IIq-0qan@linutronix.de>
References: <20260608093729.12111-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260608093729.12111-1-jelonek.jonas@gmail.com>

On 2026-06-08 09:37:29 [+0000], Jonas Jelonek wrote:
> smp_send_stop() parks all secondary CPUs in stop_this_cpu(). The function
> marks the CPU offline for the scheduler via set_cpu_online(false) but
> never informs RCU, so RCU keeps expecting a quiescent state from CPUs
> that are now spinning forever with interrupts disabled.
=E2=80=A6
>=20
> Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() o=
n PREEMPT_RT")
> CC: stable@vger.kernel.org
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

Sorry for being late.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
