Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61D3806DA
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jul 2026 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585546; cv=none; b=Ym+PqhgV4onSkaEM2PRM9/Vi5DHA2IKEIXJMmUKt75loN3lvP8AhtpHW66ivbg4kUyBrFO8jSMmSyhfpnowV+9qQY8RKkWCHlABBjMyxuklYeqymSeCv9meGxcA/sB65ZO+l9wx5f/ZfXtCbujdjylKNYJ6paQkki025lcewBag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585546; c=relaxed/simple;
	bh=CXsGzIgzV3sRPSTOEGw9Lqhhm88ADy61b/U4jpe4ahU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOMFPl+iPkE4Gi9o8WAjHGFMoZ86wI0eG6IqrJFq0LDCWiC/0MLyQ0dEi5XG4a07pjbCGWbYmZvc6LOa/OFDZYRdDxy9/MwfrGOTDD6B8j67qkQbd3Ow5sKI6vtYz3EsTDUAS3Lw9rlwXGt+u6YWXBx8qPU7luLY5bnKJpcSNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHna4ZcG; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHna4ZcG"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3810f0aba07so997699a91.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Jul 2026 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783585544; x=1784190344; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fZYBoXNfxRtgISWI6nwLbyRJgOnKdbrwsBmGvBXyyQo=;
        b=PHna4ZcGX3T4ThTefrQ6vWEN3M2bysnbjosmFUwrOkBGH1zARJ/0klOxuDBzCFU2z0
         5oBVqixNNqydxKsiLwnXpkDUqt8oDb72kbgl1fXduObKcFnYgvP+ixxs4Cw1Mr7yjOJF
         oguWu0qv6OV3J7vOh2foGkx3ccLy0pLUAMyOcefkxTzQBWvV5WP9dZgQs9R8yWF27mwO
         9XF3HUx4pPVcSqCULW3eh4/W6H9gXXkzGXibGYUGMNw1iB0pYMIo4oDRc9h5PSTNXFAv
         9Mjwy2IBx7nTiRISiJ2di8LTQdUh1LBu4DQiOVnuY2+Y4J+vqBWIH2VHHyLGFlqlbu1/
         kvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783585544; x=1784190344;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fZYBoXNfxRtgISWI6nwLbyRJgOnKdbrwsBmGvBXyyQo=;
        b=IAs+ZrH7tMAiAempk8AnaMlhEopTtrBVVtjAs5BBrwRiQDtbMJYWU0LnCwIuZsJB6D
         fFbBn85WRUmm0DAJm+Dj8yxBZJrRxw7VjRZ5ua3qN64YrPV40wPG3A77nD8PdTQpB8rK
         dijWkhzxbLFdgBF1O/bHiw5IW7xHTyCskHJKhNmxLGGIB/GHGOvLLyiOiNMfsu5jcrVH
         No5Qzo1bX7rSCdHGCNtgxJVr4qk8ah/n+HzZWyR6fXfKD6PJvMrFzt1zQ4634UnV7OkM
         CqIq0Bjfl85JHATJTU/CLdjkGeTofzWzz3H4K0JQxx9oa05NnDX6YOYL/8hjsdRJi/Rn
         PIwA==
X-Forwarded-Encrypted: i=1; AHgh+RqHTvyW7vkFC+XZairwwOjELOPL9wT2FQDODIj0oSXhwxlrQhQFaQUykUM8bBfLA7E8ra14ET3VuTxN79McuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj+ahExqR8hwSyZwiW5jxIqJA7eQHPGeGW+5tMfarkoxams9w/
	SzdMe9CWU6t2sUGc8TGeWe5k3xFJ07zgNkIJZtpHSFsb03DdmxvF5B/J
X-Gm-Gg: AfdE7ck+TU20kbjJ8OHf/1Am/P8ZXqqjPFR5zYIqBSEgYzdYTrJvXgpSbRGQcm6Aq2Z
	70obPYEC0OkpEjpcd7v4/8vFNB+Q1pmtB6WphGMIDOvL37qUTSKuajeii3poOAfSPpvgVaXhZIo
	/mMyw6T9KqyOHYhuJxzxykEknBCWBeRID9yWzK+91ce26g30jk/TGwYo1yS/BGK7PL4QnnTeY5Q
	CT2UnKgHsyZZi5mHdklzvjhncn7Y2KvB7yq3MzjgnRMkriBXL+7AIe9wk3yEP9AVDNAPJCepiTA
	F3XYiSrsfBroW9XFX7ibi+xU8DQ1objZSNqS9v6tVj0Ola2MK/UC9WZmy8F1EtyLY9Jf6m0NgeQ
	w7bjJKRzTHeCil6ZBr5xpohN6wpr/mfyJtO84boGH33w9KICDaz7VNrDr6W7oz5tyIbhAL4UHYI
	WTx6LnGBc4/XNjMvZ4JIGBsnKyiVRbK/Q=
X-Received: by 2002:a17:90b:3b45:b0:387:e0db:3d89 with SMTP id 98e67ed59e1d1-389434634f6mr6128019a91.36.1783585544240;
        Thu, 09 Jul 2026 01:25:44 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5574c513sm786919a91.5.2026.07.09.01.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:25:42 -0700 (PDT)
Message-ID: <f33a9dca-03d6-45f8-bd25-717b9033c75c@gmail.com>
Date: Thu, 9 Jul 2026 16:25:27 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm/migrate: do not migrate folios mapped into
 VM_LOCKED VMAs under compaction
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: vbabka@kernel.org, david@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, Alexander.Krabler@kuka.com, hughd@google.com,
 fvdl@google.com, bigeasy@linutronix.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, akpm@linux-foundation.org,
 surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, riel@surriel.com, liam@infradead.org, harry@kernel.org,
 jannh@google.com, lance.yang@linux.dev, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, pfalcato@suse.de
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-2-chenwandun1@gmail.com> <akz7ythMxfIZeT0d@lucifer>
 <ak0EsCeucJarlI7G@lucifer>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <ak0EsCeucJarlI7G@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/26 21:55, Lorenzo Stoakes wrote:
> On Tue, Jul 07, 2026 at 02:44:50PM +0100, Lorenzo Stoakes wrote:
>> See above about deduplicating.
>>
>>> +			ttu |= TTU_RESPECT_MLOCK;
>>
>> Hmm. I don't love 'respect mlock'. I guess we only know about the reason
>> being compaction here.
>>
>> But I'm confused anyway. We have the folio, why aren't we just checking for
>> PG_mlocked() here instead of getting the rmap to see if it's mapped
>> anywhere with VMA_LOCKED_BIT?
> 
> Also, since compaction_allow_unevictable() is a function that is accessible
> elsewhere, you could literally just have a TTU_MIGRATION here instead and have
> the rmap logic call compaction_allow_unevictable() instead rather than this.
Do you mean:
1. change TTU_RESPECT_MLOCK to TTU_MIGRATION, that'is OK.
2. move call compaction_allow_unevictable() to try_to_migrate_one? but as you suggested
   migrate_mlock_allowed function, it already called compaction_allow_unevictable()
   in order to determine whether TTU_MIGRATION needs to be added. Did I misunderstand
   something somewhere?

> 
> And then you could adapt the function I suggested before not to take a reason
> parameter but rather a 'is_migration' one instead possibly and then pass (ttu &
> TTU_MIGRATION) in.
> 
> BUT. I still question whether this is at all needed since you have the folio you
> can check for PG_mlocked...

I described a race scenario at this link:
https://lore.kernel.org/lkml/c372e68f-2bfc-45b6-a431-01bf55717247@gmail.com/


> 
> Cheers, Lorenzo

