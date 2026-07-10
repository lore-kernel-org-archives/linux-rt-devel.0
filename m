Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A73F1AA7
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672609; cv=pass; b=RXsBsGd/oY1YjByrGXc3O7TnDNsgSNFsMADPEuxNr0l3yof2/tLGOY6IZCf257YLPGTtxlCOl8klO+lkbFVJLHm3AsUMTlMeteJJ/2FnBwjQtZqQqisbpgcGJsiEZbcr1/UHWwI2EuhkiZSZtYuwTvtOoEed5fvTIhfEETezoL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672609; c=relaxed/simple;
	bh=x3VvZRtbcKKcnIyHp/en5u74HZRbH+z8+Yx2BR2/F/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUS9/uaUHCKzaDpKcMiluLJmWNVSGsEVTyv9KnpQO4gfd4+buwHJ76GZMi5bxe7HjLr8PJekQsBg8DjRz7xIWJKff/Bu0RwNLr00P79vPuJrg4xPLIEx6M6GHint55SwKYQWa4gQ/TBPQ3qceOLW1nyrtcyR7hZwtQed9dY13xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NX/hY3uk; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NX/hY3uk"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso6889a12.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 01:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783672606; cv=none;
        d=google.com; s=arc-20260327;
        b=i81gCvevQNNib8/ZxIJTzpESRxZezolmeR45i9MzutG+PhRkje9W2MqQxsgq3f1htH
         idFZojSZGuNyg9Kx90ScUiT+fonFyDm1Cud3rXVOZ9vLjKgtHzNQA+WaDeJUEyWRSCkX
         eA57aoKTWYui93+va3fo28VqX26jH7ivUdn8mYkfkwarKdDvXQ0Mbs5PCNZclCyoWBoi
         ESM3t5+9KKcj9dz3hePszlMsapoaepEtQ4v3Gzk5eOdwRcHn9dMFaSuXMjggoTvvImJt
         5hfV7e7WqOPyt+F9a35+oM5OciuwXVOVa9oOaktC5/eMZEs6+6r/bypHsv+o4xhQPrxn
         79Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5vusuleFjZncfXS2nyCDuITFoJSaIiJ699qFr3aBd5M=;
        fh=7v+rqJr1I/o55QPd3fStXohalnD2wFLoW8J9kyRbDpg=;
        b=o/6bi6jEGbwRSJdV2BkO3QnZLxxsQQqiZWExYxIAU0cApNyGAbcWfyKC9YpB6r5+Ev
         mPUCnmhTgU2xpXdREAicO7rIsl6e0Qz5w36c0tvxxYMx9sds+y5cBxi5eKOAS76yxmhB
         uUAyW8rG9mNG75d0g8wzgsKl3yY4PHnsg6n1WzLDKbKw6BfT5FxgsrTWYTJw1QfYJAoz
         jMw+paYiuRpx2zMen38f5kx8sie4T43aYBB/pcZk+R+SjGBDOf288rohr9+YSwCBuf9N
         0/6YzHTPftVmICoZDCEsa9ZF/+Wdxdi2H+lVdR6GIs3oUskRmsBwd9eUTkqalHiECJg7
         QxbA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783672606; x=1784277406; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vusuleFjZncfXS2nyCDuITFoJSaIiJ699qFr3aBd5M=;
        b=NX/hY3uk1lOxRCj+mIKqVsNz9vM9yW5ZIKKA8hQO+pibBYm9VYpCoxC4jIONPFzGa+
         Dr2FsJnCuX2FQOTWtwr4qep5RrMucEiToVmd+FXcujQEvLLpK73tSF135bUFLuVGFQxS
         N963wcdIN7l5PYimC2ZVd4KhiaNXatxLlQIuIDS3qWZuE+YkwO+FulXjqX02oNi4N6Ns
         rWZphpDF+mLXmc9Q0c20VbUEtN+gEq7D8r4ZoT9Hiv+x1Q39WoeGDikd4OMsLDARsXJb
         uXzr5Sv3uLB+v/etb9nX/1mvZgI/XBdobssPPe3zoYmoxoUCoAEVGgbaaKEV5GMSVFZa
         FHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783672606; x=1784277406;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5vusuleFjZncfXS2nyCDuITFoJSaIiJ699qFr3aBd5M=;
        b=FC1wO4i8e+l/84ERldi9s/HzLt5CtJlT7MMiFL6Wx9P/eUIH1WxlV91KFSmz/q+4sO
         h1orUJ7dgEGva+cOKqhiYNO62K4xR/jLEe45yJLN9TWlB8rLlr5+c5YgCJ0D0+L5RpHg
         /XF+tTlr50f/F1SQ4uoGYeG8iKR1g/MZEigHyIRWE7D/vyhYR/Rf9mls5JhNXiO1ef5K
         taKEhRirD9o33BzKRLTFvb0fbSQ0wlTiIF9VkfOxf0i0Rn9W4M4F4wcm4vBR6b4MiPxO
         pKonuTTOLHiv5fKcKUf/nWh1qrFhVBMYh1ZnYv2jYrqmbX7YklhowGLeiAMyXxuNwgNs
         4N3Q==
X-Forwarded-Encrypted: i=1; AHgh+RpOiStA2L+tB344c6tOkBH5aktatZozB/RhxHbdLICF/Uv5FAJcBjqrcZspCIxvUe8CgjXML66AxSMsZ++veg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYanNgN5faXv6KQb9fo28C6zFXxieMl7u05vqegrQwAImPtv+t
	ji39GSFR6IaVvIapRZYdgYt0ni0HFHxw/gpn85T1vbw5vS7iWFeOMmDnJ5bebT+M8635BrQ7B0D
	hada4Mw5T7I4EDgghNzqRWzz7IySrsU62vNktVpVf
X-Gm-Gg: AfdE7ckbQFallDEaprIgQYH83rICsr6qLCa0du/MqqoRT0BeByD0r/GhCuSO7SYqYBi
	eNPluaMa99kJgybT07ak8jubSU9OZVjvN8E5Tg84pvMyG+OA7fbQKMo1hjzDz23slBEiRAKa8j8
	eXlu3/2xx8ypSubSWfQbJyrJgffqDGzM/lvsxZoLEDRv4vui51uzW+6b/1wpox+zeSpIpt58GZb
	x64LtxdqFkXElwZ69h0LHdTZoaqbM3LiGKDd/tu0qZIQxznaxiMCA9ZJ2Nj0Ul0+PG+qtJHsbeT
	1GIGtoeDB7lhAJVfBcBofPwsrw==
X-Received: by 2002:a05:6402:a541:20b0:697:6b08:459a with SMTP id
 4fb4d7f45d1cf-69c29ed9df5mr35748a12.7.1783672605521; Fri, 10 Jul 2026
 01:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <997c1a4d-ee99-4214-be58-7ceb3b9b9a36@kernel.org> <20260705003039.c9b4bd681c059f62b375051a@linux-foundation.org>
In-Reply-To: <20260705003039.c9b4bd681c059f62b375051a@linux-foundation.org>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 10 Jul 2026 10:36:33 +0200
X-Gm-Features: AVVi8Ce87UhCHbfmvKkRHtYsfZSbDlT7JQG_kxBAkz9MTI2Uf45nPVr5mC018JQ
Message-ID: <CA+i-1C0exwnJnp-WXQa3r==d_TeRj2Ocrn9COMCdC93UiWvQoQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] mm: Some cleanups for page allocator APIs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, derkling@google.com, reijiw@google.com, 
	Yosry Ahmed <yosry@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dimitris Michailidis <dmichail@fungible.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Jul 2026 at 09:30, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 3 Jul 2026 14:47:32 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
>
> > On 7/3/26 14:31, Brendan Jackman wrote:
> > > Based on mm-new.
> >
> > Seems ready for mm-new to me. I suspect most further non-trivial page
> > allocator work will conflict, so better have it in mm to be based upon.
>
> OK, thanks, added.
>
> I also added some little notes to track Zi Yan's comments.

Thank Andrew. In this instance, what's the best way to send updates, I
guess now they're in mm-new it's best to just send them as fixups for
you to squash? In reply to the thread?

> Sashiko had things to say, mainly pre-existing things.
>
>         https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com
>
> the xpc_create_gru_mq_uv() issues look like facepalms.

Oh actually I didn't see the point about the alloc_pages_nolock()
comment before. Other than that, yeah all of those comments have been
discussed during the reviews, or are brokenness in totally unrelated
code.

There is this where we should probably make a decision (also a
pre-existing issue but this time in mm/page_alloc.c):

https://lore.kernel.org/all/DJOTMGFAPDBF.261U5OD4NPU74@linux.dev/
