Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089F426ECD
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471929; cv=none; b=W5OeYhI8N9VoNsooOfcqZXjx+qxTCkQyXQjla5JJnzn1LjzIcTH6tqu73llsKtJ3RmrvmOSMWfyLGBQO4G/kTi34H8weXjPZ4FFS737kt/Lmkm/NVGGQJ842y82krUlQJCs1hF0p61mnPaygQdKFbSurGIVAuEcq/4z9vNGaSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471929; c=relaxed/simple;
	bh=dzbQQ8/2UDtSDAyDuHWDqtlpUjc3wOLwwd8VSLBbc34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWHxlhNfJ6obmBGToYwpMc7wCs5H7EynezfXEAbFd6NlCczPdfxpCf0vO7+JUinS6OBFzPVxjyKNIbIx5QZXeq+Ie/ka0KHtf8XPUrGvCirgLs1Zh54yzLtCB38jBm095p4bZVibu6dQI1+B8seEoM6mTicjnY4cb98X011adJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=UjT0FrB5; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="UjT0FrB5"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-896f4627dffso66175436d6.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Mar 2026 09:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772471927; x=1773076727; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9jiAd70OQeRHoiPXbEJ51axrqw+4XgbTYUr4MIjZbMw=;
        b=UjT0FrB5c9YkC8sDRHxH2hFSqgfCt8DlDMo9k1Rp11agHsyVY1kb2d7OW0UePX9ZPk
         7TjFgFmnMu4/WP+01om18BCgEr7UKwNyeSBCI6U7bAgYItqtQkFnSOLWkgLMS4F6MYMj
         0r9gEyYFaeRPH720o+PYbDBDgwekA3QhYedns/IvK3VEn1skxUm6OJEv7NVgQokG7Lul
         +pMNZMcHXoetrgZAdzxU919tmfShTPkRsbLRHW5kgO6JBu33YzUpNd35WnioR7x7lx2d
         PB+hfE36AbmZ7++EMxx+wscjWWawJu0vurwm30U9bOqZAzgxB0Ut8+h7s4wb6CJHzqBN
         ND4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772471927; x=1773076727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jiAd70OQeRHoiPXbEJ51axrqw+4XgbTYUr4MIjZbMw=;
        b=QZuhqo66pj56AMnATAZCnRb11I7kBDd5fRRk0rSGBxAqWxvJT+cPv7UWyQSlyeXDrr
         T6aKZVGCAd3Gk6W6kEIPCFzTiW79/Ntcv25dOs0mGQFCCdqEL6seS5+YNa0D0BXMELDk
         JHLZHxt+CGSoIgHmArJ+5VmAyiapvPwkSAOXQ42rt58tI3bnoU7hTQWAIvwzyrk5MYlw
         U0BgYfHj+3gdMv+79HTiTcKVaRn82aBFEjPM6RO/x7inCZa4tbnKujkQw8Zd6Mw8NWoV
         QIZeLbOwEa+jiOVxGCOnQDAl5YDUbdVnk95bW9poMWH0qTs24eGRArPmy5xeq9CBUoV0
         OqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDN3jAgD/amjj57Sumx2i4bJIv5y4+2lfo38IHjmGUBa2So31Cg95l+2hxs/sKwrPtOEW8uTv9WzLQJ/YWYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YydmACFRFzy1i8PdFj33Hv55gtGBIW+DfeI1cTCjNRnDSW6eFHl
	7Xj4gW1t9oQXxFZNQlOthxVaI1wRN+kl1v5EJRR3vgpfosHhNbxR/VYziE/LAc957Ec=
X-Gm-Gg: ATEYQzxufrq0a61r+/AIOj8Ou07JqLzyaPPiHrsBLa8F8Ca3aM6BH+m/lYr/3K8fBpA
	/IjiHFMlLeJsXkdZr446uMEausn3jJtXfZIs9xV7ml3kR4KcsHf9miymcIqTgStB7IVS4cyNpdQ
	1QC/phumDwpgFvdWNodu7KzSJaWeOe6iriDsS8v+L2dUTkz9XxaHlIW9KvxjNQhi76Gfc7CsCRY
	iH5/cQ2HjGeWzOjpKj/4LXMIZ/5p/pf31I9sN1H+7IoHhLaQNO8QCFDWPGF0288BWJJe0hiKBty
	JMnLsJiXJCOfK8g/HcFhtU++SIWP8qtSNQcXVVyUfwQeX1+TcjvKVdAhvFpGuMkTHgErrRKrphB
	3tcDUT25NoRQVDv3GmbFp3eKgMzzlSZAI7r5l1k8aK6s9IIvG3J5MIcm9dgHQGp0ItVfYFW95zD
	h9UqskB3TM3Xkr/L3qAjYltrv71zCsId9j
X-Received: by 2002:ad4:4ead:0:b0:896:17e6:b3da with SMTP id 6a1803df08f44-899d1dba572mr185242286d6.26.1772471927483;
        Mon, 02 Mar 2026 09:18:47 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a083a95fbsm982926d6.38.2026.03.02.09.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:18:46 -0800 (PST)
Date: Mon, 2 Mar 2026 12:18:45 -0500
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
Subject: Re: [PATCH 3/3] mm/page_alloc: remove pcpu_spin_* wrappers
Message-ID: <aaXGdccssMyvmz5R@cmpxchg.org>
References: <20260227-b4-pcp-locking-cleanup-v1-0-f7e22e603447@kernel.org>
 <20260227-b4-pcp-locking-cleanup-v1-3-f7e22e603447@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-b4-pcp-locking-cleanup-v1-3-f7e22e603447@kernel.org>

On Fri, Feb 27, 2026 at 06:08:00PM +0100, Vlastimil Babka wrote:
> We only ever use pcpu_spin_trylock()/unlock() with struct per_cpu_pages
> so refactor the helpers to remove the generic layer.
> 
> No functional change intended.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
