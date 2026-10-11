Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D32399350
	for <linux-rt-devel@lists.linux.dev>; Sun, 11 Oct 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745832; cv=none; b=rlsCPemMa/Mkz+m2mVuYab7YXSPavhtCv6tWqB+CR8yOwEXb96PszvMz362e4gosTLEmQzqHhHSch+Se53W0CgKTA/gTwibEx8AXgR1/Q++04ScERRbqc1uW6pzbkKZ6GVJ2gfCJNx5frLD2pk2rRYTukktaIcEMqQdjrApRARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745832; c=relaxed/simple;
	bh=RjdAH3Y9wwiPn80wJQYztLmuKKN61VaF2ABE+OfYkgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwbZ5SgXPq9kO4WJAxfic6VSVf1KZUxrszyP8BsSTC34V3Q6lagoJRxxTlsN/qDa3zVfuIffg/3ZioRgfhAwukWC6kXMh6ekhyu6bxrpnBOPpw17GWm7mxuwJMNAlwC5HiFq7bVbTsYs6AhslLt2RzyYB7jaZY2JtGZIbI28VLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf4ISkLj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf4ISkLj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so10347145e9.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 11 Oct 2026 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791745829; x=1792350629; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QTR42Go9m+6eVHpUpw7SmlR7Yrf00JHufO82pWXeBX8=;
        b=gf4ISkLj1EiAsTWlG/dKBE8nZBgBCZofrrlDbn2izP2GzmzgSnfJR38MbUicZGj++e
         8c4fP/rSQfVRbliSHoFY2kMV7P0Y7w9KZLfMLkty3q94+D3c3rE1Jcy2JKCcDJb1pqui
         BGDRpAe929D3xv2eoa53eqHcnw0WpRa8L9kdkS23AWD/kYcZiJXco38QArwA7fIGfZs+
         5G34GLayxIOkrZZDP3LAgvFF9xYLtySm5aCm4Dz+1l3cNyj7ZWWVxIhOH0xQzQIduD3m
         U0oNI1oUhnBu29YDLpM8rltbtytaoSNn+ALtjnNpJAuXRvyL3uc/KX4PVCFJIpjqRCuy
         qPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791745829; x=1792350629;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QTR42Go9m+6eVHpUpw7SmlR7Yrf00JHufO82pWXeBX8=;
        b=HzvYR1Tz8aHmiMgfNirbbQ6Ozqsl9fDRg57ZFHBM1ZhwFQPESGTHkY6ONeA4D2UDWe
         41ybsaruD/ijrppRYZsrDJ/YYT9IhEr9iVyQ1cv0kNql95nCL/6dfUk8rpNnplTJV3Ls
         DTNEXja391jEZYNzQskB9ZXsa/SDYCyATla+wk++rfTvUF+HkQ6P4ldu2z2SzGONBfUA
         hsH/LW6BRzj7VHzIpsNbgieJoFoE/kOVdr5/x0G0GVq4vGrYFZvknpFAfjwuZoHSB7ev
         M8WU1Dn6byzLAsYrDpJ01TDytlri8nuzsZaD7bajVIaPBomd3F+gP94dJLsLaWiOP/x8
         8S/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwOxW9P8mjiK8TcS/Zu+VTmcaCkCJE6b0aGsM+eaeY6KInrmZlsds1CMFMezWlKkqH+RIABQm2hxIb0T68hOQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIaroaaOT+EMhswV5JUXrXSB/Z7IUZgeN+6Tf93+QabYRs6bxnu
	SCOVAAEpAd9uv35uGGArq+QJOJCsd3Vk67Om+qRMvZda0hhBziRTfcjH
X-Gm-Gg: AYBFou08HnfegDeMu9q+radzbXfqF4MW6Nc8gYJCPsFOO6qU9twNqJBnDb44uW03frG
	p9iokVAHbKWaV2AwR2+NQAYxbJeNTjTyhTqEHW537VkdjuIsVR5rQgIgEJpA0Bdtu9jfzxx1rKF
	yrMH9xkbgkEOi154q86XRLNMQvsFZkW8mEI5tSUx2Yr05QPg2a1MriKOanneTH+SNH64sW9cPkB
	QB4fxO25Nxw/9UOrhEWI0Um66HvmbfVZU/Wopw0D5A8b0FL1cBDv54dwcE4ANa7If8lJPImH1Z9
	UUVL9/2ZR5tADDA0gxQqgMG+Xad4mh8117oocizDqTin+BNi67EqXE4P49GaT1v3wsNYvtecPQP
	OtrA6kSpHwkSKc4WuUfbrJ6NiZKjzoa9CcBIAeoagio8R3ePJG6nCoM30oIi3YQ4+Pl6GmvgS/1
	L8NnPxRm9d5Zp7MnfTxb3BhOVuiW+UkVJn9hEXjUQ1nTqOW9uHeUY0AiKgQmu8EDLu//vk/jjXA
	Ibev2Cl7lRpC2g0EgZToiGqj7ehwGgjVLcGQGz4Yed2QLVqwZeWSrA6BuPbmCYIuB0DNPOKuX9u
	hqb0mPEOjbgd/zVnMAW1axmqHvNLK199Wp7yl7UHT0T9DqTTwtI0tjY9y5ThZxqn/hd4VJtiaT1
	xvsoX
X-Received: by 2002:a05:600c:8518:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a18e4a8ca6mr128648855e9.12.1791745828643;
        Sun, 11 Oct 2026 12:10:28 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a124-4001-d491-d32f-6b9f-21c5.310.pool.telefonica.de. [2a02:3100:a124:4001:d491:d32f:6b9f:21c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9adf5e6sm15237808f8f.56.2026.10.11.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:10:27 -0700 (PDT)
Date: Sun, 11 Oct 2026 21:10:23 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net v2 1/2] netpoll: use a raw lock for the deferred
 transmit queue
Message-ID: <asveuLDEf6a44bkD@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
 <20260930192103.62973-2-kmehltretter@gmail.com>
 <20261001074819.gQ3w8q6P@linutronix.de>
 <ar7sTVun7mF-4nl6@gmail.com>
 <20261009155225.6Uy7b0wd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009155225.6Uy7b0wd@linutronix.de>

On Fri, Oct 09, 2026 at 05:52:25PM +0100, Sebastian Andrzej Siewior wrote:
> 
> I would suggest to untangle that local-irq-disable assumption. Then we
> end up with the ::write_atomic callback on PREEMPT_RT which will raise
> warnings. But those will appear only on panic() and as the last console
> due to CON_NBCON_ATOMIC_UNSAFE so everything will go according to the
> plan.
> On !RT the whole __netpoll_send_skb() will be with disabled interrupts
> due to the console lock. On RT it won't and I don't know if anything
> down the call chain assumes that.
> 
> To illustrate my idea a bit
> 

I've got a candidate based on your sketch. It keeps interrupts enabled
for the RT printer thread and the deferred worker. IRQ-disabled direct
sends keep their existing path.

I have one question about retries. I've kept netpoll's retry budget of
about one tick, with BH disabled until deferring to the worker. The
IRQ-enabled RT sender cannot poll, and with the BH lock enabled the wait
holds off local completion work.

Would you instead defer immediately, or enable BH between attempts?

So far, the RT locking tests look good, including on hardware. The
generic change also removes the sleeping-lock reports with macb and ENA
on Ethernet.

Panic handling and record ordering remain open. The non-RT console and
IRQ-disabled atomic paths still need to be addressed.

Thanks,
Karl
