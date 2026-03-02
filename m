Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12B41C0BC
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471576; cv=none; b=B6UDGjcuLw5C/ZYKqlLo5wQfIAw5PTXkkq/2MA7kgT35yU63i6lxSofhprdYajJtshOAf89YKp+RnwSDRznlv6RPqZeIOm8r8+IBsR4CB0wzOmKlfr+KOg0IQxF94aq0IhFjD5LzrW+U+wRtsHpixjrwbn8DqWQAQbQ8SGX5SIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471576; c=relaxed/simple;
	bh=OPMdAESDGIeNBXWvxHugves4Hzd4QErL9F1dxR1ce2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOOM2J/ZHWKrodzONLObh1mC5WsyX5SMa8GCMGoTiM29jdHuiz7ZZqQxQILV0xAtztbPIC4BKDEUM9zUX3spCnDC6syGogKNPNxaMUa8FykMunWSSAZ8K0zTX1Zfhuvd7gcaUR6fGAG3Jb0pnRxMFRB8ngIO20L9UNB6YrXs43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=aEeYZrUU; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="aEeYZrUU"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb4097794dso461208185a.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Mar 2026 09:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772471573; x=1773076373; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NYeVLOSy11BGz8w/+PkZCxVtenIhIQDcWYxLFf6PHw=;
        b=aEeYZrUUejy3nJi5tUo4n5F4oy6QgFKhv/vdDRkww+NB9TMkvqrpk8xodtzhyl+3QL
         +uFs0ZKTuKH8neMveawTBn1PgS525bQwnadDcoivJ3xmZvZimYShW9c4DCwm/lLOw10H
         kN+8/2fHsO/r5NolzMoFvkrj6to0tGfw85qcP83BXEQtiyCsOHxK50izCpYf48yU4Taw
         ArGkvvthjdQQTboo4elR679yz70tuWUpaYPI/jiOFrEdS3ZZX4BCb0PAAa2eyzQRXMAz
         pNZaJi48AGRXftWQr6ah4aClGZx6Pu6ZcN7hrJRFh8se78jugpN25v4Rd7cwYLtXPgVd
         Hhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772471573; x=1773076373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NYeVLOSy11BGz8w/+PkZCxVtenIhIQDcWYxLFf6PHw=;
        b=mhGFRphywuWCwMg/oMV8G0Kkdx7U5IltWz3h2ToelX5bJOHp1mkbI4KCBmdmcVFrET
         6omhVaHv3zzMQ7D8nj07XhTSKkvZYxyj4dOaF/4P+KpdQCglQumrRr3saMqiy40YHhhs
         nh8FwQ37i2LVu8QlZv0F7FMNnR235Ta9BI9L8H5IFZdJbKYDtKBWlMYKivVPIGSPGvtA
         7A1OjEmlsrelnCJjyIz4L3MTPuV57VibhKnkp6qTG7Yc5LmWoSQzDiCCEd4AHRT0PjwS
         kJLxyOELq08vcJoLFRPPdHVqbrp/IuZU09TcMBKtr/qIqX4v2hwdSxw1OJJgOosXHPuZ
         /mng==
X-Forwarded-Encrypted: i=1; AJvYcCVwoKXZJ27R1vtbnYwFmCEwqiPn2VREgEmap+N0q4HQI1WEOZMdASxPp+h0qkl66WIcrG/Z8I/7dyElxNR17w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzilOUHbMWzoZgzFsFSu3YEApnfYNdwF3DMI3aAjlYpH/O6y3C1
	vQVfl1FFRqrN9GMFMqq2J0LTxqb+oPmfeMV0IctIjvjPScYDp4Fr4RNnlxiYwufSv5g=
X-Gm-Gg: ATEYQzww5ndVTQ/Mf9THFVvAK513XFau/3iB0yrVjntK8Y3lWjBZBxWTZskkO/9fpFx
	tS/lTNj38jx/uM2BpyFtUfLyQBK39S3uEfQwx3+qZl7MwWbT3uDaQwc8+OQWid85QQoe0id3Xpo
	i0YrQucR0p1mFwsInrmrfZhKxzuPyFc25loln3KqCKujiE/CjBmuUs8i+MRMhLNhO5WnRvDKjWt
	gcE98z5xEtyfFAgGPl67lgmubY41CMKYUvTAHsZgPu6KOoHLmXTsZNvIZo4XykiN5H4OTYGShOn
	uaccYsCBKlrVoEMckCE8pjlAdtI2SqeBjrXKl8KTvvvhT71L3rouBpwNI0ukw0lB91qN78UHjwE
	tN6C8jGLav1nmZ6q5ItGrqqnj3Yg+vLunq0CbsJl1cRFnfSZdRXSKXTJMfsXpkGFnc1nLh7WJOu
	6Wcj8OnJAqeQmAqKp4hD+G/K+OqELS/DlA
X-Received: by 2002:a05:620a:7012:b0:8c6:af5b:d50a with SMTP id af79cd13be357-8cbc8de839fmr1760779885a.43.1772471573065;
        Mon, 02 Mar 2026 09:12:53 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7374dd7sm112302256d6.32.2026.03.02.09.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:12:52 -0800 (PST)
Date: Mon, 2 Mar 2026 12:12:48 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Matthew Wilcox <willy@infradead.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/3] mm/page_alloc: effectively disable pcp with
 CONFIG_SMP=n
Message-ID: <aaXFEDw2jrBGZNm7@cmpxchg.org>
References: <20260227-b4-pcp-locking-cleanup-v1-0-f7e22e603447@kernel.org>
 <20260227-b4-pcp-locking-cleanup-v1-1-f7e22e603447@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-b4-pcp-locking-cleanup-v1-1-f7e22e603447@kernel.org>

On Fri, Feb 27, 2026 at 06:07:58PM +0100, Vlastimil Babka wrote:
> The page allocator has been using a locking scheme for its percpu page
> caches (pcp) based on spin_trylock() with no _irqsave() part. The trick
> is that if we interrupt the locked section, we fail the trylock and just
> fallback to the slowpath taking the zone lock. That's more expensive,
> but rare, so we don't need to pay the irqsave/restore cost all the time
> in the fastpaths.
> 
> It's similar to but not exactly local_trylock_t (which is also newer anyway)
> because in some cases we do lock the pcp of a non-local cpu to drain it, in
> a way that's cheaper than using IPI or queue_work_on().
> 
> The complication of this scheme has been UP non-debug spinlock
> implementation which assumes spin_trylock() can't fail on UP and has no
> state to track whether it's locked. It just doesn't anticipate this
> usage scenario. So to work around that we disable IRQs only on UP,
> complicating the implementation. Also recently we found years old bug in
> where we didn't disable IRQs in related paths - see 038a102535eb
> ("mm/page_alloc: prevent pcp corruption with SMP=n").
> 
> We can avoid this UP complication by realizing that we do not need the
> pcp caching for scalability on UP in the first place. Removing it
> completely with #ifdefs is not worth the trouble either. Just make
> pcp_spin_trylock() return NULL unconditionally on CONFIG_SMP=n. This
> makes the slowpaths unconditional, and we can remove the IRQ
> save/restore handling in pcp_spin_trylock()/unlock() completely.
> 
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
