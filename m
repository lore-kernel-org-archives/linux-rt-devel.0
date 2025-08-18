Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA3253B59
	for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533804; cv=none; b=UNjuhgC1VYTXTSYgEqzPbA0I3cleoz/YORd52PPIT6G5tL91zZxqXKurdUVLMuu0J4oFiXFAMlLwZg197oW1fTRo5BZ2NjRNM8wri5BfJsxbTP2IXxvrqVf1DldgXggaunjAIw0dkY8Oi9bgkxz+k2chTdUDR3AOoeZf5P2x0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533804; c=relaxed/simple;
	bh=+KreY6XCVUhqfgIGGcQQcVGaWgajloEjSzZ+NQsv0Bk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DFrHUDnkLGx81e+jrqCLk+LQKXiBstBLu9kaLdcGauFat7DKiaCp4543ULqtDOtNPu4/TnFCvw5XWc5fQ6wY9+jFB6L7k4wBsTNrLeIs2HJUlT405IzJ6hjWLGKPsFI9It67TiJG3E25Zsu+lKUd9b2cau8EIBGRJWOT7gppbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DKq8OlQs; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DKq8OlQs"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 29B6A40AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755533802; bh=Ki3AMnJXQIVgxf0vfWmzLXaMaAZehzEkoGm5efNzOvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DKq8OlQst1vmDzpKS8Gn4N8tQBC1USZWkeAnosxd15GskYHbD3PcVcKCHtXdCFAIt
	 GxTVMyP503mr8NEv3ZUvk3935awdgT1rvbThRfrX+5q85vh/vaT27fA9C0doSpxFTc
	 jZ6HGrZWDrifUsTxOO6AKDn2VBqF3EP7cXK2PIOn9jnhgMHjAeRaQypBYuUxinU4j0
	 WJ2QwuVrGotqX9qz+VEm36d3/giiTAZPxsTuJB1KODGvfMDb1hUCfEn1/xWYV6RslJ
	 e6q7RI2XstLBwpNBA2gPHxy+m5SQUBpRM6263qi4rh8mVjdg78YKZA0PXvxk0xpPe5
	 Qv+dZ6K2876BA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 29B6A40AB4;
	Mon, 18 Aug 2025 16:16:42 +0000 (UTC)
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
 <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 3/3] Documentation: Add real-time to core-api
In-Reply-To: <20250815093858.930751-4-bigeasy@linutronix.de>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
 <20250815093858.930751-4-bigeasy@linutronix.de>
Date: Mon, 18 Aug 2025 10:16:41 -0600
Message-ID: <87seho8v12.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

One nit:

> diff --git a/Documentation/core-api/real-time/differences.rst b/Documentation/core-api/real-time/differences.rst
> new file mode 100644
> index 0000000000000..50d994a31e11c
> --- /dev/null
> +++ b/Documentation/core-api/real-time/differences.rst
> @@ -0,0 +1,242 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================
> +Significant differences
> +========================

That heading text will appear in various places, including in the
rendering of your new index.rst file.  In such a setting, "significant
differences" doesn't give a lot of information.  Something like "How
realtime kernels differ" would be better, IMO.

Otherwise, this all looks good to me.  Did you want me to pick it up, or
did you have another path in mind for this work?

Thanks,

jon
