Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256444B663
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982034; cv=none; b=S9Yd9Nd6eALuERfurWwyc6HLVDhe1hA+s2VEYdDOZl4rsQnDqLxw01ImtygZAqWlUwluW4aei2LzxeKWWFCNmnQG11fCiL83xHPvYL1yw5UxBwtJoLd/LH3Mmzjp6uzv2KWWCV/5LI3AxE+G+VddXLAQI7lgLXxvx4NWXZgpRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982034; c=relaxed/simple;
	bh=RpoILnJcOwmoWgCXxV77A9vktCtupEDKgxu0h0tYNzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSQeiX8Dem1LDCxlEZ1wdmXpgkeTHDto5NPp0pEriTD7OxW6E1a12iwJwlt0ONrPFlYApJB6beX6dyz1gJq2TpEbDS/QK5e8B3PZWK5Dz6odZnNsEifBfEokQszjcayZ4ekdxdGNRDk0uc/3o2xCYd2EJuQAgVB6Vr+jcg6FUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d4kCt325; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+oMVAel; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d4kCt325";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+oMVAel"
Date: Wed, 21 Jan 2026 08:53:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768982030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2q8M3UrjydVqdDqxNGy9BOk1w9FNNPzwD677+fHY+I=;
	b=d4kCt325DYPw0em7fsICBVjO9HzFxGIr+z8RYkEbepqy0r6WtWhehG9sFc08bCVdVQRty4
	zYo/awKVT6iipvx7KGWrhFWvrXoPCRF2QAmaCS/8p70LEQnSX/szukrPTgLU0lOhi/+b8+
	J88TtrvVC9hJYyeaApJNJE0YXn3zSbRXMGIehVt19255IGthfD6DA7blw6GXUpsd1d4EFG
	Rx4FCMw8kjuvT/nOLKKNYOhCsLsDFBmDyCK65/oXUtbSB7ic5TT4DZGT/whpCmM61x2ZMz
	1Z87rTO6+F92JC0RJyqbTgTtI/OgLIrEb0hPLPxJjiDagNKKAjzyxhKhauq19g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768982030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2q8M3UrjydVqdDqxNGy9BOk1w9FNNPzwD677+fHY+I=;
	b=0+oMVAelr4theE4TX5E2r+mfr10029bnGW7Mt00xpEpQoMgJod/RCMzx3WMznszzSqvXDN
	PatAUuf0C8Q9JwAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: hansg@kernel.org, "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	sfr@canb.auug.org.au, ilpo.jarvinen@linux.intel.com,
	regressions@leemhuis.info
Subject: Re: REGRESSION on linux-next (next-20260115)
Message-ID: <20260121075348.5MyqcHFB@linutronix.de>
References: <555f1c56-0f74-41bf-8bd2-6217e0aab0c6@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <555f1c56-0f74-41bf-8bd2-6217e0aab0c6@intel.com>

On 2026-01-21 12:42:16 [+0530], Borah, Chaitanya Kumar wrote:
> commit aef30c8d569c0f31715447525640044c74feb26f
> Author: Sebastian Andrzej Siewior bigeasy@linutronix.de
> Date:   Mon Jan 12 14:40:13 2026 +0100
> 
> 
>     genirq: Warn about using IRQF_ONESHOT without a threaded handler
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> 
> Looking at the irq register code in int0002_vgpio.c, it seems the warning
> comes from
> 
>         ret = devm_request_irq(dev, irq, int0002_irq,
>                                IRQF_ONESHOT | IRQF_SHARED, "INT0002", chip);
> 
> Looking at the history, this flag was added by the Commit 8f812373d195
> ("platform/x86: intel: int0002_vgpio: Pass IRQF_ONESHOT to request_irq()")
> to resolve another issue.
> 
> Any proposals for solving the WARN_ON?

Do you have the ACPI interrupt also on the same interrupt on the board
in question?

Sebastian
