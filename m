Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626824;
	b=SvEEb7uc4Av64bmmucM6GB9U9LL7P5alD2MfMj/VZE3z8g67PeXOTenMC8YpvAR6V7m+
	 UID5SLd9YXLQmGOdCwv6XwJRTAdIr+tiuND3TgPDqTJXLsLcjChvw08IwJ/0thSHd3Lz9
	 BJdqhIQ7oXFcfw3vxPmALZHt4pwH39qZliAFQ1/Uh2xAnA9MaBy31o31sp2/28zav2Pg/
	 tDVXJEQG2DNZfLv6cdISmgwh9QKZdOvUWgw3qzoXTDT6zBeq6pqX9a86qOhxTdajxIMZS
	 /yuuZDVqUy8hpf0UCKSuBtqDMrrzxy4D1c0IUv8ofqZGpacjVGOLO4kKwcpN8PAYGfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626824;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=iv+px21u03acEcz/Te2xTvJ8wZ/dIalo57maBeWzen4=;
	b=E3qRARVbRPoV8wxfJb9tfEEmJxAZbe6gambP4MAesvshc33q935mysIfP8UN27AppKVK
	 EhPm/HS6noO8pFRcJc0BBbQK1v/RQxFBvqY9MbPluzdcx6BEs9tRzWFgmXpYZPhxCQkAs
	 h19R+/96MaMxCczLIhoNP72Me/UPyDXSodLyGuh90driRuKOWZT6qcfRLUwe/Wqd109oj
	 VBhbggmDkgtDWUscvgVSkukCM0synHE6iTWJNi6Vx1h/wNjFRKBOKotp/wmVutWynhX0C
	 YerN+hzcYPoasO1ZJtPonxdyn2dhn1m4R498GlDqMl5ncywzBQuqjDlIRaD+kVQZMdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JeG4GVwh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="/tXzigM2";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9190B606A323
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 17:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9190B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JeG4GVwh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/tXzigM2
Date: Wed, 25 Nov 2026 18:13:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795626821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iv+px21u03acEcz/Te2xTvJ8wZ/dIalo57maBeWzen4=;
	b=JeG4GVwh6hQPbU/WOqM54k0bb0Gs2JHILuryozuHJ4f/TgN4Sv1dL6D2JeUJYhWdZEpBED
	utyyFvciF6exfzHVRSeAfm7eJF/owOT1mUz1tntsM1TsLkaqVLzYnAJ82ieJeQfGo8C6wK
	qP5K7RJjYIWmpfjfV5HhIULdLLVQc+j2qlYuDhHzG8McWUVENv+oTTXypwg/3+owRnPaBF
	epOR2vluDUeeKlf+dKmXuqaHQWdey7BgM9AbUj+vrOzpZJRZkpQk5SP6sD//4jaM835qNh
	QVLx6f9kusviOHJyJmqIdGjjgxwVSI2a7WGkedWAUbI9sSRQUw17yQY4TDnhFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795626821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iv+px21u03acEcz/Te2xTvJ8wZ/dIalo57maBeWzen4=;
	b=/tXzigM2fQGDch4K8anWVS1JgUpnvQjhFWwDLmOId17QOhxAwsIYvDbfwmka4+EcN+xkcB
	CKLe34eqmgdhy5BA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Zixin Wang <w1355457260@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	bigeasy@linutronix.de, frederic@kernel.org,
	john.ogness@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, corbet@lwn.net, wagi@monom.org,
	atomlin@atomlin.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Documentation: real-time: Add runtime tuning guide
Message-ID: <awcXRDKtZJqNrhby@lx-t490>
References: <20261125074658.33117-1-w1355457260@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125074658.33117-1-w1355457260@gmail.com>

On Wed, 25 Nov 2026, Zixin Wang wrote:
>
> v5 -> v6:
>   - Split runtime tuning out of kernel-configuration.rst into
>     runtime-tuning.rst, following Ahmed's review.
>   - Keep the CONFIG_* section anchors so kconfig-checker links stay
>     valid, and link to the new guide from the related options.

Thanks!
