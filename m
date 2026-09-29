Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB34E0B9A
	for <linux-rt-devel@lists.linux.dev>; Tue, 29 Sep 2026 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790717143; cv=none; b=SHTjSXE2orgu7TRmHlfgxZVuW430dg1IsA31K+9IQY9QMQAlmlLX46quSPkGkPR6Tn33D3V3y88vf/9inaSQEY4KKPw65PfVg1+E55jxHLRTD3gCRBzO4xA4ZNrKcby2K3Vh7aV481sL03rGNLOxiYe9nxQQnLzk3qV5It/xsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790717143; c=relaxed/simple;
	bh=Tjs7FwpG8SBJ1qS8KHelfEMZVZQILD7n6hgU4O1XLxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I49pA31B3zYZm+aIL0uAgg7YsCULUOMZrKtpI+O1z/GxqmpXYl9aBCIQL1ggRVNmt5/dQ+SULlUz08HI+GzFlIrPUy2UIpgezQeiHgCXkgghvYHq7+1BAQ7aghspFvhNL987vmP68PSkfZvzTU8vvjuDmoLvw1zzL4nWfeiXm8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr5OZj9j; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr5OZj9j"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so6413875e9.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 29 Sep 2026 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790717140; x=1791321940; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o4P77awGw7CnoZ9LloNVfZMxMXD8dRiBGwj2EdNOf8w=;
        b=Lr5OZj9j/n5ImzidDJcH6a3IUpDEgc+3KjoDkJKjEDSIqv0n+gxEr+GTf4v1HvKN9R
         MrqEz+OGV2VyCsG+2yCJ+UkDE5kwN2SuJgElisztf/szX7XhXMWp1jHmv5+TYqf5huKN
         q8XmcqjI7lSetwyPsF9dVQM62BzkXOSfCLVQHB7oK36QoYkcGUT9HhxjyTEXRjXRO35V
         17UIP3wlrNCCS97ck3iREzPG/ciMTRRMzk93TeDWTrtVO6gQLQTjfrFpXqwWeycoGB7J
         AeSdSL+Y8DmY/RRtIq6+Jbezi/r+bESrK5sHwdPYsvD7VcfNGWIJ720pOGz7LgLf3X+o
         Ww7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790717140; x=1791321940;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4P77awGw7CnoZ9LloNVfZMxMXD8dRiBGwj2EdNOf8w=;
        b=Tymo27UtN4QkdsPXQeN+6+yrne6kCvJeMMHM3AkSZY6us+mdZIeEBznzqjkDsJIP8N
         j07agWIDm7/y9PRDc/2ZKTfQv43pxGzc3QiFQ5LRKnpKkfUnkFkfoP1wTWdMGwActCDx
         2YRjmMtZQXKGxaasigspllYQPEK0uJf/E2qH3gqDSRPXwB+ltyUBZhOUUE2TDBbCgcm0
         3W8hkJ/0qrYFsdR/Pq86i+GBauXKWTvDubQbwcwsLLqRejlMZJoriFHz7ty3yOAVj4Nb
         Tn1D146+0o4vrzcsXDT1JqSOnB46eWfp1HF/VsAoui33N4fvtrv3s1FXMv0XyIjjiUBk
         upAA==
X-Forwarded-Encrypted: i=1; AKwUvBzedfJ1GlNhyDzexPEnWZ8wDMkFGA0dCL1i3Og5a9ccFvAYXsCuj9VjxSGc/r7MGNoapuC5kfWuMhNhTtU7ag==@lists.linux.dev
X-Gm-Message-State: AFuF++nJKe9qB8zL4M+rZgZeyO9KpQZDxE0E/guXj741U70NkasR3Y5i
	pYcFCXpPUVhXJIxOrwQBeLUc8084nG7LLQ8/78cd1O9Ez/ChR5fyjs1p
X-Gm-Gg: AYBFou0vSKnm7PmpiuO2UfoqHiRh9zh0xbm/oIPDEVrlByowOaTD1cbfddC1xQburfn
	c6HsKOzODyDG0CRL8EDXAJBSP6FNbRaHAufq5bT15ZZgsERr4R8+mjZuuaO+M2dp88t7wggZ7ha
	luZm4vLzQfBoK7awHSsCBAQ/GSJV0eOoWuvau/FzQVNM0xpofYCfpqaQgpmcC6u8GFsMKlSh42/
	v7m6CW5Bxbas7PmeO5Gsxcg9ZpASYeiyqX4bCuP/Dyyc39wNLCrP2kkRL9N2DTHrBeSzOQzhWfJ
	neh56IuKSSS+OgQmmTERSxouJxM2lc9akyWzUffr+wpAj+zNsLVjAHAhSB2WBVek0zmFFESyPI6
	shV45FlccfoZzLOPVn/ORmVoF338jfORltU3Ft8caJtELgwD4xm0SHbLMurpIjgKRotgylTIqJr
	ODdlX31hC1RXXsmfjSiGtBq/bvqGB/zzKHvhdMJT8fwXf40TMDxLmv4fswXtAiE/dNcj9wrkBkD
	XI5vNdjnhgOeICh+aGlBpdEBbMz2e5f9OFOPjOQOBtgI/PDPCH0HHYSQXQm1WuGBzH8nrD+dAKl
	shbOs+l9kK3fwd++84EJEUPRixSFkMPTUTPTN3RJOwdn654JTmhiSQ7OT2RQNaZAeyBaRfHmiqM
	=
X-Received: by 2002:a05:600c:c176:b0:49f:fbad:29ae with SMTP id 5b1f17b1804b1-4a015142604mr5797515e9.17.1790717139884;
        Tue, 29 Sep 2026 14:25:39 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9c32-f801-9d9d-c89f-9fb1-4ec2.310.pool.telefonica.de. [2a02:3100:9c32:f801:9d9d:c89f:9fb1:4ec2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfecb39sm118395395e9.7.2026.09.29.14.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:25:39 -0700 (PDT)
Date: Tue, 29 Sep 2026 23:25:37 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Bradley Morgan <brads@mainlining.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] softirq: Preserve interrupt context during IRQ exit
Message-ID: <arwsK1dOHVB5KZjD@gmail.com>
References: <20260926143505.66024-1-kmehltretter@gmail.com>
 <20260928082402.1iCSzDzY@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928082402.1iCSzDzY@linutronix.de>

On Mon, Sep 28, 2026 at 10:24:02AM +0100, Sebastian Andrzej Siewior wrote:
> could you please do
> 	(in_nmi() | hardirq_count()) == HARDIRQ_OFFSET)
> instead? This will merge NMI check into the hardirq check, dropping one
> conditional jump away.
> 

Hello Sebastian,

Good catch. With GCC it removes one conditional branch on x86-64, arm64
and arm32. On x86-64 it also uses three fewer instructions.

I will send this tweaked version soon.

Thanks for the review!

Karl
