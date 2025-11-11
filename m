Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C607361DB6
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Nov 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874257; cv=none; b=JhAxLapsG8PKFZLOAU3OMOXoMzsR4U05zpclXVTGx8QAHGLDQzMjBqUNjfKUHI9zwgCq4CtSoNJSdLCRThBpe58udErEmZLjACD1Srkmyrch8AMz/4SjjoGdRY0TB1zHH8FFVEENSsh9SalVvULasQ6OXMsA+y2+ZNBelhi9FAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874257; c=relaxed/simple;
	bh=YhoUZTyua1QAmmrb8e/8LARrMabF9LiuiX/42OF18QY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MkW727CKobiAD5VakefZ+QExyiFkv6q+HKd+POJ4tl/JMHGOoyg1m9dqcxLmKMs+P2XrdP/6bZhnnherS+/BI70Pr9yQIRAKT6qHwwaiiSxZD0eKDw1jRzEjzOTGnGLJsbxyDwJoYDlhoGSIJLTakugrm+4y7FAnaIx1+LlD0vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VUti9/T3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aMeGcHzI; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VUti9/T3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aMeGcHzI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D07A140008F;
	Tue, 11 Nov 2025 10:17:34 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 10:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762874254;
	 x=1762960654; bh=Fbu3o1viLABP5wwcyk1daQb3Sd8DU0YDTxiJGgrhldU=; b=
	VUti9/T3aO3GOccYKmBXHz3ZdrMX+USsxgD0amkzVk56cWDvANDlSlFQnHoL7Kx0
	gqEWgqKdmekAvqSegPZhBB/5VzCy0IM4F7lPqffkCugMHgGDkyp3I6eZh7ddCGvV
	hA0cxUAa+uI3ad1XJVOLENV7i+WiczHGeZQjWbnmHYNjPqLoqK7NcKziXqoliPoc
	IUV0jQAO17DR9PYC76X53DNKjYZD/3+eZFq/wFwsOLc6VMQWnQTGJsMteX9rOhzs
	bVZOd1XOAmlfy4F+hT2XaPCA4Pc7ftIQjgA3tKXdUFDNJ7WTY3qtmOBV1dbjgDeD
	EBZB0Z8Il4CbhJDK4hPowQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762874254; x=
	1762960654; bh=Fbu3o1viLABP5wwcyk1daQb3Sd8DU0YDTxiJGgrhldU=; b=a
	MeGcHzISOSoh5+tCaefsiGr+j19DZT0+mU0YUmRIjtJpgZTg2e26E2A4PEW9HOH3
	Jb9tZVhL/KiLA+NRSd80EC7s9lLyDvQcjvT/C/zuhh7chKjARrBKdMV3G6lQ5zsR
	Tj8CapfRm4uP8G6a44DNsWRQkV6K0pLAQhRPLGnMPzn3kLx5qR2BIroXs2xLv0Yx
	oWjK2iFzulajNzAYY6d6SMihuTQDMeToY6lZ/QaXlC6S0pOsS8p3FxvOuKbNrFAG
	6D6I0ArYxUqJwPaUbZjK2BEZK+802ZtUF3YtDDJveUnofKoOhnA89uhsz1otvjGI
	pGX50DBKVNdh//PkUdiVA==
X-ME-Sender: <xms:jlMTaQQxtKQ-WgNTjxRcDDZ6uukGQ2s03XDaITI1-xtpUfxA7dUNyA>
    <xme:jlMTaYlKAYhESnDvbZ3pVH0MWYlUE7qq6crNRXpVZmLmk2xXjoW_dwvPODCMmF070
    uKYWslmioMtNCV-of0BfjPHvf_xnJj6e3ceW9-eL_GBoL1GGRY4H_Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepgfegkeelgeeuteejkeevjeekjeeijeehiedvteeghfdvvdetveeiuedugfehhefg
    necuffhomhgrihhnpehlihhnuhigrdhorhhgrdhukhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigse
    grrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepgihivgihuhgrnhgsihhnudes
    hhhurgifvghirdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinh
    grrhhordhorhhgpdhrtghpthhtohepsghighgvrghshieslhhinhhuthhrohhnihigrdgu
    vgdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhrthdquggvvhgvlheslhhi
    shhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:jlMTaU2k2-P6zMJQgGny2FLIzH1cIO1K-TAnCaWgBbTNQXTCy2ZtBg>
    <xmx:jlMTaRUn7JWQaNE-MOQNT06EcmtP5qagvghBQRpUNVOqZ4syBuAbzw>
    <xmx:jlMTafJdSSnYdOd4HB7dpcblw4vGBoyTCA_VuShPAuRJoRHuk3g2KA>
    <xmx:jlMTaT3aa4RdA5wnMtHX-cCWmEp73qXsAS9dWpGWn_oeyQDvTng9PQ>
    <xmx:jlMTaQCwAqvl9XRUFEp7s6TE3RBJJhlJh4sHdsi4-i9T6ar8kUGG1nPn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0D718700054; Tue, 11 Nov 2025 10:17:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: A3J-1TSmcyGB
Date: Tue, 11 Nov 2025 16:16:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Xie Yuanbin" <xieyuanbin1@huawei.com>,
 "Linus Walleij" <linus.walleij@linaro.org>
Message-Id: <8d7c55f0-ba20-411c-93c7-bb354614c0df@app.fastmail.com>
In-Reply-To: <20251110145555.2555055-1-bigeasy@linutronix.de>
References: <20251110145555.2555055-1-bigeasy@linutronix.de>
Subject: Re: [PATCH v3 0/5] ARM: Remaining PREEMPT_RT bits 
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 10, 2025, at 15:55, Sebastian Andrzej Siewior wrote:
> this is the last batch I have to enable PREEMPT_RT on the ARM
> architecture.
> Last time I posted them there was some discussion about making the
> branch predictor hardening worse. I redid it hoping it improved now and
> does not make it worse.
>
> Is this okay now?

Looks all good to me.

Please send the series to patches@armlinux.org.uk according to the
description at https://www.arm.linux.org.uk/developer/patches/info.php

You can use

$ git send-email --add-header=\"KernelVersion: $(git describe --abbrev=0)\" --to="patches@arm.linux.org.uk" --suppress-cc=all


     Arnd
