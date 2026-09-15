Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780D374A19
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454637; cv=none; b=EeTZT0i8mI5Dc+l6R1FEn1WMZamaG4mDhgyRVYzYJXT5/p0xdR58/NYpuB1epuSIAFzEp2Po8u+WGDWS19YSCSdPujGC6Xk+jKR6KJ6/hyJQn78vP+vUpAdMmSl2q6SIEibN1AwMjygy8PlIQOreN4uXukITkG3eTJCmDhMvNac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454637; c=relaxed/simple;
	bh=Nc8vEsGYa+LoClpVrtKU0ctY95f4Lq144BNAOinqUFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hxv+fZ20NTIq/jySxpDjZ+uEKLGS4NTI0EchpvRApQHoQggBqA+VHK362i72U027LqeVe7k729CnvLggKvW9GCn9ENZP0xiaIWEmUjFRk+ax2fJuJXJ5sPt0eyMykoeOyNkWFyWbXuQIESy/tE4uP0Ec3bzA7Zk+D7uk5xZwkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zdthx9WK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TkJG47b9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zdthx9WK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TkJG47b9"
Date: Tue, 15 Sep 2026 08:43:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789454633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n8npRe+Ba2NJYgzLW1W2s8uAuAt8W67MqQDs/DmOXgg=;
	b=Zdthx9WKDdWAtub0fJPsq4ybHfZ4ztm5qziXY4BS+91J6gNnPDqb0x3MjsmeJx/rH84bco
	c2iRGnoz75HM8vcmjGOZoH/UKIGTbc9pyvzP+OElYsC/GyuEqtkccgBLH21e1NwCHhrx6k
	gQ36azHNyEHXI4yBjZimagqMP99KFI/CuRlCmWNskC6EtwmRje1XD5AUtSg0TLhOHmvFvf
	8zBrDNshEy52ce6VgKbDDiALitZoF4KldfzoOFch1rWRrWTby7eguGYHaO6LhYzzXotenO
	KKamQ7Oi7McOwyRgzgaadT44a6KQL1ZHreLc8xTxP1VTUK6TfFbAuVEqe5R40w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789454633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n8npRe+Ba2NJYgzLW1W2s8uAuAt8W67MqQDs/DmOXgg=;
	b=TkJG47b91aO4UL/TX0i5aFN2dg64ywHaFv1uzvHxjEEWIBaRZH1/3lQjFUAUxLgIkoYPzO
	fjll67g6FjmYb8BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCHv2] gpio: mvebu: keep resume masks within the irqchip cache
Message-ID: <20260915064352.T4HiPnt_@linutronix.de>
References: <20260915004406.115230-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915004406.115230-1-rosenp@gmail.com>

On 2026-09-14 17:44:06 [-0700], Rosen Penev wrote:
> mvebu_gpio_resume() writes the edge/level mask registers saved at
> suspend time straight back to hardware, bypassing the irqchip's
> mask_cache_priv.  genirq skips mask_irq() for a line it already
> considers masked, so restoring a bit in hardware that genirq thinks
> is still masked leaves that line unmasked behind genirq's back.  An
> asserted level line then has nobody to ack it, and the moment
> interrupts are re-enabled the chained handler storms, hanging resume.

Why is the mask value changed after suspend?

Sebastian
