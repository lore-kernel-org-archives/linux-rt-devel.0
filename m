Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F434C808;
	Thu,  5 Mar 2026 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772744724; cv=none; b=erSEcMycX/SYfMQZN66xxFieHW1ATbR0BnMJJ7Ic6hcgUx4+k6vhJ9uiuSKqOhSK8kfFLOwLwKQW/lrKT8x5M8FvUydXI5sqab5qWMKDJZUr9cqzqbvOGmJzJ/44tx7oMiW6O0LsabpOgGMm3KPWNJuHVdE7fkvgAP+hGBH3jQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772744724; c=relaxed/simple;
	bh=oDct3wkkDkvzXVyDoc3/OxjAVH/7WQOliRg3Z7GPQ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1k6i0+w+Oq1SmLqLyCjUrtJxFMZ806gj1V6VVJbqHkfpJV8VoNlwCkhkl5/D4N48xgWFhaTfF5txOkUq3lWIZqdGM2M7BCt0RNqLIzWAEdPSCCIfhy8XDVga5KPxmzcSo8EM77rGkqqulRTxAw7h+Za7nyOctyp2H5mUg4uXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IreocQWj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IreocQWj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HcTdYTXdgwQjq3ZeCQXDIArUfEJ3wy2VSCnmkdCGjy0=; b=IreocQWjMemR2FKtMBP5a/Zsq1
	I6IFFuEFdE4eWdMwyhoz4VeSWpgLDgiDhK5fG+xkI/YS9Nv20yBjNOoNsColmDn1NRvb/cW6oARJa
	le8hFSQYirhjHDfHNRocVnqkmaBK8PHiW/D38yX1drVQC7vmcSv/SgCZ3UY5hwCC+S9ENt6vRuzH8
	mQSeliMYYQIu5oEBQ7r6ik4/USrOwgCqyS2l+rOzULmeTL4NULnusMP/7i6xdCnMXV9Bokd6C8zcg
	k54o8xt6NOLKTKW3S/ZrzIbw82EupS9+yiGpqzI18ltaIdCKiPnz2aM6DC9hEyyxaa/2oUORxZdhI
	owShPkzw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyFsh-0000000Fddg-48Hh;
	Thu, 05 Mar 2026 21:05:16 +0000
Date: Thu, 5 Mar 2026 21:05:15 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <aanwC228bGTa38LK@casper.infradead.org>
References: <20260305205023.361530-1-darwi@linutronix.de>
 <20260305205023.361530-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305205023.361530-2-darwi@linutronix.de>

On Thu, Mar 05, 2026 at 09:50:12PM +0100, Ahmed S. Darwish wrote:
> +==============================
> +Real-Time Kernel configuration
> +==============================
> +
> +.. Add a ToC so that all options can be seen in a glance

Is this a useful comment?

> +.. contents:: Table of Contents
> +   :depth: 3
> +   :local:

[...]

> +``CONFIG_CPU_FREQ``
> +-------------------
> +
> +:Expectation: enabled
> +:Severity: *high*

Importance rather than Severity, perhaps?

And high/medium/low rather than high/medium/info.

> +With that in mind, any false real-time kernel configuration could cause a

incorrect rather than false, perhaps?

> +new maximum latency that shows up at the wrong time and is catastrophic
> +for the real-time system's latency.
