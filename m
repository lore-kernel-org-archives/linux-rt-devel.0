Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3646C84F;
	Thu, 20 Aug 2026 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244115; cv=none; b=jfZXOczX0c+xtoud5t2kv/dXC/8ouhqCiCt11H26eOVptvhoUgsvNEBb86w2G0zphIdpZ0J2LDDp9ITAqhn5hML7DrZ1njlCZwk7vxHpuVZYk8xDcbMKykN59z1gYhaSpEGYwFg+N+q3rLmHqDq/wGl8GlpZ60Qd55K9ELXOY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244115; c=relaxed/simple;
	bh=XYVElV+Jk0gL+yGQDiAXMrMf5Jqk5fyT2oWtYhLd5Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFTH4XjEqCPum697lOaUQYFTwjn07byO45IoeFPCmGmKLVCi8UQsDrOcIurJAqAFvUIAX1wmhNSxgJh+oKKpXV4v2GznSruwHl15MbEvfVDFfDTiNfZHyt8LHd+xYvpiLHpsNsvGF0RJaUAPodwxHzICpvj9i6JvFxsN8IXSBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyhAdJ6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyhAdJ6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0442E1F00A3A;
	Thu, 20 Aug 2026 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787244114;
	bh=aLz4f+Hk4HfGPbGDqQZgNNxr9lDGlubcQpeUIHcO3cE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LyhAdJ6Ys70M2HKfEMjqm64T25fAtue1GHRERfuNMdYzuhjrdYY/eFT/y0zTI72eE
	 3Q6p/c+EYTZ0wPIVU1UrJ2TMDQ9Dsm3TlEo4wC+0xC96XtpTGJeXfphSQozBHOKBc2
	 3UN+4Swd2+cOD9FRquj8T8sCQw61YTOkSxwBsNd8KUM61f3LuwrgW0z2/tf02/JcsO
	 P6VGKZUDMLPp5kfSJM1Pzlu7QHj84qQVWvIjV76ibVmnVBcDbcMux0ikoFmSOKXYrL
	 i/6dhudroJ2cQuKolSHxOAE4/+NbwnfeXb3PFs0IzjXngENyrIljQjmUUHE1Irmsq8
	 7KzekzcAXraag==
Date: Thu, 20 Aug 2026 09:41:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton
 <akpm@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, Jan
 Kiszka <jan.kiszka@siemens.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 2/3] genirq: Honor existing IRQ affinities when
 setting affinity hints
Message-ID: <20260820094153.420202f6@kernel.org>
In-Reply-To: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-2-3f79a99cadaf@siemens.com>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
	<20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-2-3f79a99cadaf@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 16:30:31 +0200 Florian Bezdeka wrote:
> Some device drivers implement an IRQ balancing / spreading mechanism
> based on cpumask_local_spread() and irq_set_affinity_hint() (deprecated)
> or irq_set_affinity_and_hint().

Not an expert on IRQs, but this may make the API even more confusing.
irq_set_affinity_and_hint() not setting the affinity seems odd.

I'd go the other way and either have irq_update_affinity_hint() apply
the affinity if it's safe to do so, or create a new function for
"defaults".

Really, the drivers are dumb here, they are just trying to pass to 
the core a hint which is: This is Nth of X IRQs, please spread them on
the NUMA node where the device is attached. Ideally this (Nth of X)
should even be part of request_irq() args. IRQ core already knows the
device/NUMA node. Drivers juggling multiple flavors of uAPI-shaped API
is... not very scalable. People rarely get this right.
