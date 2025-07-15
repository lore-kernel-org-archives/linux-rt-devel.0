Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452D1E98E6
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590896; cv=none; b=jWgUBJUhND/M2GZwv5i67JLaWppCpDaHbIMWTMEudPHKGx8rvNbkoSH/zE2g6KYXv9QaabA7E244va991BV7ZoG1lF9MHV3LpPWYtBxtTlnd/bfKK+cRZUVtW7jhnznCis9BqB81VqB2TIhsrhMfA2asqdRxopOQzvjHinh6VP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590896; c=relaxed/simple;
	bh=Fadl6gW80+jkN33geS9JhYZ5eUC0zYPPBNeJrFQPXrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iQ++j4z8ZJilMuBu1tqzYuFWiIKdAffXKF/2GTBXbEkr5rt+Zn9v74OetDLjsEFlR9OBuE0sP0tFtRlxaksz19muv2++c3Tw00JWGEjabdN1Rhi1+HWNBU/3bwRLJX8qL9oiIhju1GlJm+kHRo4yFPAoIxoN1a35uoAvfvqKjZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=flOwfRBv; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="flOwfRBv"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 255A54040B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752590888; bh=mUxOuPQ3i1RqvXs4px1+MNR/UFh87k7ngQmWgbsqArQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=flOwfRBvM/DUllED5tMQyEHOod6nONAIH11BexG+S1vgP+DQCKnrfWxxwQxpcuTPY
	 IitMv+jWWFaBzTZswNxcHB0/3REbPNLFFsPWAxm18PPe/FcQPiaY7PJftvIu5rmtPX
	 skNdibS1zo6bnLddQHtuENtKM0wPN0okKByd0BNEIEHj0RLsQXaoBsF3h1vL6b5K0R
	 +QXSn0Oumu/tXUtippaN7spE02BaRKb0aa7vMypp+oQkwjEu/qT2SVvDm+fQPPsYak
	 1M8sMEGToyq3EBEh43nIwDH+60zNKRdBqQxHHsVHaZsmdQgFCpHPKedC5quA8L2n1O
	 ZJ7Dz2EmAf+ew==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 255A54040B;
	Tue, 15 Jul 2025 14:48:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Boqun Feng <boqun.feng@gmail.com>, Clark Williams
 <clrkwllms@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, John Ogness <john.ogness@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider
 <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, Will Deacon
 <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: Re: [PATCH 1/3] Documentation: seqlock: Add a reference label and
 license.
In-Reply-To: <20250715144127.697787-2-bigeasy@linutronix.de>
References: <20250715144127.697787-1-bigeasy@linutronix.de>
 <20250715144127.697787-2-bigeasy@linutronix.de>
Date: Tue, 15 Jul 2025 08:48:07 -0600
Message-ID: <87ikjth5nc.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> Add a reference label to the document so it can be crossed referenced
> from another document in the tree.
> While at it, add a SPDX identifier. The majority of the document has
> been written Ahmed S. Darwish.
>
> Cc: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  Documentation/locking/seqlock.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
> index ec6411d02ac8f..4936b46dedc59 100644
> --- a/Documentation/locking/seqlock.rst
> +++ b/Documentation/locking/seqlock.rst
> @@ -1,3 +1,7 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _kernel_hacking_seqlock:
> +

This will work, but you don't really need the label.  Just say
"Documentation/locking/seqlock.rst" at the other end and the
cross-reference link will happen by itself - and plain-text readers will
know where to go as well.

Thanks,

jon
