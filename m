Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C283E3C66
	for <linux-rt-devel@lists.linux.dev>; Mon, 25 May 2026 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698524; cv=none; b=dLMkc4clTfF5xmTCPASjcmIySqu515fmvLWKOHQes5TBoK+Mv+rvzffwLYq4PpFVHg8hY6MXOuP32TezEv0dAriuMvvnVeMMc+3wODE+GvYbiiKM8RBpXA+IUALRzntuVTJxe+dAnPFvf9Dozw6QVJ/quuHuTScfQuX9IZ6Lnj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698524; c=relaxed/simple;
	bh=Qaas3Xi9KKGq5oO/yBUGZjifDR7cy0n88kvn4dABAbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSN61AwoFn8OnTAgS9SKi1atLgNpP8Fy281TIzKeuo4sf39IJvmYTrV2a0qruy84HLMCvR+XwqpjDc4TdjG5d5kQzAluurMnDbUqKf6Txwutt8LBgsVAkDcg4ljKYxVcrzbgiHjTrfdD042E14KSd5BWdTi0n5UidNutm9SZKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xc0w0Ujs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xc0w0Ujs"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso37036515e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 25 May 2026 01:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779698521; x=1780303321; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TGM0HnwsQ+sAC0d9nq1+H2+fQIQXp7hPnnfrzxBYUA0=;
        b=Xc0w0UjsEmBG9z0IMuVK6jYDpBGRqFuodK4K52vGYeiDhFNQXn6cfLO+PxJB2Sp0qP
         O50KA8v/Rvt8G7uVTb3LJzgbDH3snvoR/3gDT8iW6XJxLVTVLnNSDQ5XKaR9Oejhe6VN
         06fnpyz5VUq6WkmsVOskJkmNomkTYchjWtDxk1WMt04D4oingI1E2c2UIwuVI64db0hS
         WKXin1XAzULah/4fMSzZj6wv3GeiTD0o/S6ZtY2b+zi5nMzkj+H20Ac3i7Ijea4cIwmo
         SD6liaJXEd/ogp/nrNkdQd4jVEjZUmYweYs1ZloEtFH+cMv91ga4w7wtdiyIf6NfhpZX
         X8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698521; x=1780303321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGM0HnwsQ+sAC0d9nq1+H2+fQIQXp7hPnnfrzxBYUA0=;
        b=l9WFOkwvwN0IArhsS/ATaT60AreUiScKXx9UwqZ+4b7FNwz2EHPoi/1IjyCv4ZYGfE
         VddUuPzec5grxW4EtQl694IDZHWYccBvfSYbGtHiSnoG6UbHDWYwsBKCf3QA5Q27UN+d
         1eNdHK3lJO+q1CbrjMpOTqNkCtrN9EmUlicug/X68J5O4BAywX5ishrvilil1OLyzAnV
         HB5YIoaOAO168oHeAz5ZSXOOBnj0rQdi1nmIq5aZJjosyUm9WrFXM1jLnDq4MmMim1FW
         tNMs0NcdNrmOLWHcHJz6pKWNPuq8E7wuRrjZicHiwAjtztrehkPBYjyH8ie3EkX2dxBZ
         +UAw==
X-Forwarded-Encrypted: i=1; AFNElJ+M7XRli/TAojf9c19wR9PTZ2NulfgwzDpz+ZTaA9HIER4FCRTgH+V4b2D0bXwBelQaVNtEwqZm7Kn3aBuEPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7tNaT9lJMuLA/KeN/ILZP0VcQsMv/N0JO8IR6b68pF8jnvjyc
	LUDJxZzdAcEToUo0RPr8bNTPgnI7wje4vEnQ8nJskdK59L5iWgH+Swslwj9IeN8BHOM=
X-Gm-Gg: Acq92OHzX8hHvAWKggusdJZlWHNh4K73zhE585U0lg/Kr4YJ41R06wiv+ea9elvJe8n
	n8BcGFaxG0HMF/d7HaB9y6IOE9bcanmxMrj4W3Cx0fR9qWlf0tv7/Z+JI17+8dLylndKP4EXeA5
	xFxaYY0GSd0yO4TKBwQlsT4jnSkDRgeK34/YXrjCrFzSzca20qUojgEOK/LEEskTUy6OnglB7/r
	2P5MKTQrSi2qGAo2URMuS6L+Ky5cvUABBzqz0GTV1qfrDYB2ryZ6p9x3clKoPdBHoP+Wf4JYjit
	mTKJLD55SHNnk44gdvnEpvd21g9f/n6O9o7NGQCl6yD385rZ/ZU1FvRMw4e9XClMGWbRKRkXzST
	uqjgOEEY4UM7fpGwNAUVcuQ2o7veecskBD4nSG9O+totR6Dnsad9pNEY5JOzVqw17ajQUGelNB3
	3UbruuN+lmhFd98BkNmRKBYcc0L80x8+VzjfXD
X-Received: by 2002:a05:600c:6095:b0:490:51b9:2309 with SMTP id 5b1f17b1804b1-49051b924b1mr152029475e9.29.1779698520913;
        Mon, 25 May 2026 01:42:00 -0700 (PDT)
Received: from localhost (109-81-80-247.rct.o2.cz. [109.81.80.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428ee444sm82000815e9.24.2026.05.25.01.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 01:42:00 -0700 (PDT)
Date: Mon, 25 May 2026 10:41:58 +0200
From: Michal Hocko <mhocko@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] gfp_types: Introduce a new GFP_ATOMIC_RT gfp flag
Message-ID: <ahQLVgj8zV4xQRh9@tiehlicka>
References: <20260520204628.933654-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520204628.933654-1-longman@redhat.com>

On Wed 20-05-26 16:46:27, Waiman Long wrote:
> The GFP_ATOMIC flag is to be used in atomic context where user cannot
> sleep and need the allocation to succeed. However, it does not support
> contexts where preemption or interrupt is disabled under PREEMPT_RT
> like raw_spin_lock_irqsave() or plain preempt_disable().
> 
> With the advance of the ALLOC_TRYLOCK allocation flag in the v7.1
> kernel, it is possible to allocate memory under such contexts by using
> spin_trylock to acquire the spinlock in the memory allocation path. This
> does increase the chance that the allocation can fail due to the presence
> of concurrent memory allocation requests. So its users must be able to
> handle such memory allocation failure gracefully.
> 
> The ALLOC_TRYLOCK flag will only be enabled if none of the
> ___GFP_DIRECT_RECLAIM and ___GFP_KSWAPD_RECLAIM flags are set.
> 
> Introduce a new GFP_ATOMIC_RT gfp flag for those PREEMPT_RT
> atomic contexts.  This new flag will fall back to GFP_ATOMIC in
> non-PREEMPT_RT kernel. GFP_ATOMIC can continue to be used in contexts
> where preemption and interrupt are not disabled in PREEMPT_RT kernel
> like spin_lock_irqsave().

Before we go this way we need to really be clear we do want to support
raw_spinlock (aka RT) contexts. This is a big commitment because it
dictates internal allocator locking that would have potentially a much
bigger impact long term. I would go this way only after/when we conclude
there is absolutely no other way and we need to have allocator in those
critical sections. Now you have a single place which complains ATM
without much of an explanation why this cannot be really handled in
other way. Have you even considered any options to pull the allocation
from within the raw spin lock section?

-- 
Michal Hocko
SUSE Labs
