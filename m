Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519B17A317
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591201; cv=none; b=ePUf767YePOYVUURLQuk8P5tIcIzPJ6CJjZntkUH+GMXaAhCgSmRgwtFTlzVeIifuj3DZ0pQ5mv/pmhavaiU4L7Bd6VPHp213p8+7BO37JViFXtqG/gt0IF7bChizintU4lFxamImXgyHj66yufUwUeDl9Hm4ZDwv/CfFfQwJHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591201; c=relaxed/simple;
	bh=tEsFO+pS3hn7cj53TCQKeuNJ2pHT72WStW+DfEsrJqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhjAkCkB8KTD6l0uIZt1TdRubCJZoQaiCWUKbbXfq/iNEP9xIeWIjs3ExcxnQX/h9DlYlCIVvqRbQRDXyGATg38xux+b1h1fD+/ZN+5uFd07UiOObEVO1fe8qeVr/I2dCU1U9GICJ4uXl3615Gl3lGv1azp5wZPfR93vihp/uvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d4qB1fB5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UsNCGPfK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d4qB1fB5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UsNCGPfK"
Date: Tue, 15 Jul 2025 16:53:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752591197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOqAydDHeTW8AT1Zs6RdnvfkkRRFPI0U2KjrczuNs40=;
	b=d4qB1fB53dsB7wJolan1Yk56mcNELzuWBLH16mH1LjdvVHPVtTZUNiznYp2rXSdBIH9dwQ
	Iveie9GOy6fH6bd3LTO2fYXNRFpAjE1j4vaNJ7+xa9ZaduMz8Pt/lM9wmzBL6+wPSqXx/6
	saca0Q+sxfyF1ktgMj7axxwTVGtr/eSDeaB7lu8NfhSr6U5u7PgGxnszdVPWnGtIVYuzIE
	V6btAfrnp3N/aUZVApS4MY5e2YGsESDuuEoY8bEd2p0FEefhcQAEV/2adSEC7kIKSadHI3
	fr/LUTsYFBYKE7TtVGT0yIyDdWk8+fS7XYYwpm1Jv2xKJWs9xuyTBLw6Oa3lUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752591197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOqAydDHeTW8AT1Zs6RdnvfkkRRFPI0U2KjrczuNs40=;
	b=UsNCGPfKwVxOXfzRlqH1QJjz1giCcJqz/BpD5HfB3zMHM62GMqpmAYlgD3PkSX8OPtgeVC
	XzxNdsL8z1JWWXBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: Re: [PATCH 1/3] Documentation: seqlock: Add a reference label and
 license.
Message-ID: <20250715145315.qVcBbkCA@linutronix.de>
References: <20250715144127.697787-1-bigeasy@linutronix.de>
 <20250715144127.697787-2-bigeasy@linutronix.de>
 <87ikjth5nc.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikjth5nc.fsf@trenco.lwn.net>

On 2025-07-15 08:48:07 [-0600], Jonathan Corbet wrote:
> > --- a/Documentation/locking/seqlock.rst
> > +++ b/Documentation/locking/seqlock.rst
> > @@ -1,3 +1,7 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +.. _kernel_hacking_seqlock:
> > +
> 
> This will work, but you don't really need the label.  Just say
> "Documentation/locking/seqlock.rst" at the other end and the
> cross-reference link will happen by itself - and plain-text readers will
> know where to go as well.

I did
	 :ref:`Documentation/locking/seqlock.rst <kernel_hacking_seqlock>`

and you are saying just the file path without fancy :ref: is enough.
Okay. Then I keep just SPDX tag for v2.

> Thanks,
> 
> jon

Sebastian
