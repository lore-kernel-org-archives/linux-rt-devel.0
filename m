Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570B30ACF1
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419530; cv=none; b=AHV2d5zJc2yHIPzQ6YuKz1+uZqgXmlPt5Aylurw7YeXobTEcBFX7alZZWs3Vw+t5USKovjymmaDwvhk9OHiqhy3IYOBQsXThE+h6Hwi8FsBWC255VP1Mkb32Oz7Kq/L4DHgCkll2B6cMD56hJBT6TtxbVlLCgkvvnFvvhN3oK0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419530; c=relaxed/simple;
	bh=Ezy8VtKdhj9ZVg1i4NBi3Yinb/Tf3uLPsujA3zrC/sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deL1UqIHCvb/i7u4nuF8Zqcgw2Id5dr+jyD3luSJ35wbGpNb6cnzg/S+BuMY3zRBGEL8XCMkKnmWMYGKdwwyVPK0fT3jtGJC5vlDqpDllzzaPL8Xq+AGAN7H1flszgtKqmIb50dQkIgintp4QYs3bbs6j3rv18T0SwOFLkUcYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xd6DFElM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CtrONpqO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xd6DFElM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CtrONpqO"
Date: Mon, 26 Jan 2026 10:25:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769419524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dn0W/PFlEU4YEb/xmoScZ6WFuNY8d+Vj1fnNaxu5P7I=;
	b=xd6DFElM5KEgUieV5dtzZMP0xlC1gclp2zv8fXTKD49RoTKrtURYBqtpg6F38ooDv2fzwV
	iRxtgQzkIEp5mLFso8nOWJAXTeXMzQbIkuaixWNo/37STQQI19/g3dY3hAf/1h2cF9JsxF
	x+iQBsvNGT7DWkhlSayh8EOLAGrZeVdYoYFAlVGZm5ewFNF9S03SFT/bQvJ6JZsLxXUEd4
	cDmUrWQPtjZLCTRrJk9aH7kJs/dKXu1Ff7zyPpNPbypc8eWrvy6sLIh0FgcsHhVEfajYHc
	UTgb6fFWFnZkR1DNrTZ3BGy3tQveHF9OCIa6QaR153SAXmcvG9K3KlRkX5CGgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769419524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dn0W/PFlEU4YEb/xmoScZ6WFuNY8d+Vj1fnNaxu5P7I=;
	b=CtrONpqOx09YxTJyTfa+V4kRMNeLbjxNCNYvkoI0fuu3n2kDqZm4/Ol1M9ubVoqwFuhZ0r
	2RpsBbakZrxcObCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 19/21] iio: Use IRQF_NO_THREAD
Message-ID: <20260126092523.jm0QzgTW@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-20-bigeasy@linutronix.de>
 <aXOK0vqIQbCAw7mx@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXOK0vqIQbCAw7mx@smile.fi.intel.com>

On 2026-01-23 16:50:58 [+0200], Andy Shevchenko wrote:
> >  	ret = request_irq(st->i2c->irq,
> >  			  &iio_trigger_generic_data_rdy_poll,
> > -			  IRQF_TRIGGER_RISING,
> > +			  IRQF_NO_THREAD | IRQF_TRIGGER_RISING,
> 
> Maybe swap their positions as it's done everywhere else for the consistency's
> sake?

Almost missed this. I swapped the flags, re-ident-ed.
Also updated the commit message that ad7766_irq() is identical to
iio_trigger_generic_data_rdy_poll() and can be replaced. Hope that works
for everyone.

> >  			  "itg3200_data_rdy",
> >  			  st->trig);

Sebastian
