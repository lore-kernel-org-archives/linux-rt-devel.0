Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BE743932A
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Jul 2026 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714298; cv=none; b=JUcoMulaZzWvGGXyASAVNnUmeK3Sm+1pdLrJZ9Jz7O13wp9rigWK0P+UtQ2RAvmRC1OnUfTHkzREmK9pPEFYJUdIVJViHPKj6YPqF2mDM7WFUMNkxdDvkcGiTxcNSMJnsR37v2Ey/NSN78NgjHJAizl4md38Z136fmGy1PR77Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714298; c=relaxed/simple;
	bh=akDU7xYh0IgyGRFadM1zLtDJvjoGFRPfM3elobo9fME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlFwYlJpicvFvUmorSilA4uzEwd5759xpb0uBpbK/4g5lP6ZmxTAoskLNoR12r3vCOwsbu1L/z77W0t1/U9vdrgAq3DerdZB9pIFAh7RN8PsojZPQgsIYNnzt+8j7qa6y627C2dS/m1PxrY72YNV2EnZ1vbuv1AkG8kSxVRXHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB7WVD9y; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB7WVD9y"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c96739a46acso6750114a12.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 22 Jul 2026 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784714296; x=1785319096; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ijy/gLpb1NwFXbgR00G1evfvLl/4vAA++YOqxk207ZE=;
        b=ZB7WVD9y8+r49rTmttcydQrhdie5BZQ/jyIYzCQHkPwTvu1i3BdfXifQO1SP79Xjls
         RwUFeQ/7t93yxWveMPnWDPUU44SN+fc6+i3h1DYEuWfNH2MY2Z2bzF6sjMyDoujH+EFz
         kcufdadHhVKE2yLa8LBoi4H4WrBQaui/djUBxnqpDvpwU5zFENm14vzkB60QhgrUK+GN
         BubTz8AI2H6sZ0rXV5hEAMVb/Qn4lAFx0yPNFUvF5Xh9mkefW4EQjINsZjLGqTYOsFj3
         DUSmVtkmSRsR/r6dZ7U6pmBD4winC83sNd9W7KVRIUrMOw64WFlao86YsZ7coo+9cSxU
         5b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784714296; x=1785319096;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ijy/gLpb1NwFXbgR00G1evfvLl/4vAA++YOqxk207ZE=;
        b=jvK/yDSx7gfR9iRjP28YbZGSiha0Ilo1Lf8uvrgWMur8JZZbHsIzuWnMXB1LOtcGlM
         UQc8JYlnFr6WL88soEICv6tK/KWS1baO8EyVqt/Mr7h81BYQKpTvQ8lvj2sUL3eHa5BK
         NeHxIQCn7HjMskE8tzukddd/ZSyiYYwEc4oWASQ6T7s6T+dD6Y4KyUj6B+WOiUMjGzYg
         Aj3n7j82vaFQJITtWM8enaHYJatIodQbPNFxrlEioDz56gT5YdEaDIKPMSsBfzyihKtJ
         N/uDgThTB74BPmsmEv95o+5xpk8mJImuwFXhxrxHUcUuwb2V45WoxUpuoUhS+Z084hnZ
         Iu5w==
X-Forwarded-Encrypted: i=1; AHgh+RpDo/NLqFpRT0QB/l4ogjFf+S9S2E0VHTs/hxFGcx31vg5dABzp271FPvFEbmOiC+vA3UmnBhw+qVTmZT790A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxwo3qC9s/vJun5QCQgL3Ocvbh3LApOmeaI0WLI9ofFw3FYEncW
	BpsNCwDGI+2lrozSsM+t2AOMQsXB8POLhnpVCNYE1k8fkOtpdzZxFGf9
X-Gm-Gg: AR+sD10uMQZRqzpvQno/HMVqczbcrYVAJMaQNnz+Ssg/lH/doaDz/AYHe34rqk0Rue+
	t9EUcZhdSJNulsNq2PFxrbAoiE2oJA75eYcms2vaXyR4v1oIpzzPgi6iqUkhN50ycEHW2tNTv46
	TZGIKwyhaMDkM+PdIFHoZvKuI2rc8PFCBKr3hOw5zn+tsdOnd6x8IxBSGV+fqpwMTMog+Bf5W/1
	PKjor/+6PfJMY6iKq+JuFAIWM5nmCU1dLzONX6DIuR5Sblr1jHsUC1ANVtZoHxN6if4EthhwYRC
	s6j+kYCZKNeMO3ZMm/vAzP4RmbKE1FGVPpD5FamCC0vx6QisvrkSgd/dmFxp70M3KxFZRv2Ljom
	/AegpbCzirIHTP4vTF0hrrCXslv2F6oXY1YJzJAMLJgt1UW9GVnDM3NVNF2mLH32QtgPg8arlUg
	RJG3QmeKQ+iQ==
X-Received: by 2002:a05:6a00:23d5:b0:848:4754:28e5 with SMTP id d2e1a72fcca58-84c292393e8mr21888359b3a.16.1784714296477;
        Wed, 22 Jul 2026 02:58:16 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e172862d3sm1045545b3a.22.2026.07.22.02.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 02:58:15 -0700 (PDT)
Message-ID: <2e9902e7-3f40-49d5-afb0-e710fb01ab39@gmail.com>
Date: Wed, 22 Jul 2026 17:58:00 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mlocking
 a range
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: vbabka@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 Alexander.Krabler@kuka.com, hughd@google.com, fvdl@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, ljs@kernel.org,
 riel@surriel.com, liam@infradead.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, pfalcato@suse.de
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-5-chenwandun1@gmail.com>
 <9b227263-56d9-41d5-ba8e-c969d8d68785@kernel.org>
 <20260709131509.iIPP2VBh@linutronix.de>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260709131509.iIPP2VBh@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian, David,

Sorry for the long delay in getting back to this, and thanks a lot for
the review.


On 7/9/26 21:15, Sebastian Andrzej Siewior wrote:
> On 2026-07-09 12:04:33 [+0200], David Hildenbrand (Arm) wrote:
>> On 7/7/26 14:59, Wandun Chen wrote:
>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>
>>> The region covered by mlock[all] may contain CMA pages. cma_alloc installs
>>
>> What about ZONE_MOVABLE where memory is supposed to be migratable?
> 
> Would it be bad if the pages would not be movable anymore? Does this
> effect just memory-hotplug or something else, too?

ZONE_MOVABLE does not need the same treatment as CMA.
1. On RT compact_unevictable_allowed is 0 by default, pages in ZONE_MOVABLE are
   never migrated by compaction, so no latency spike, no problem.

2. For the scenario of memory offlining within ZONE_MOVABLE, because of offline
   is an explicit administrator action. Any jitter/latency is expected and
   acceptable, the operator chose to offline memory and would not do so
   during an RT-critical phase.

3. cma_alloc() runs at runtime, triggered by drivers as part of normal operation,
   and isolation path hardcodes ISOLATE_UNEVICTABLE, so it migrates the mlocked
   pages and installs migration entries. The fault-and-wait latency hits the RT
   task unpredictably during normal operation, which is not expected, and is
   exactly the spike this patch targets.

> 
>> Also, what about drivers that mmap() CMA memory to user space, and
>> __mm_populate()->populate_vma_page_range() would actually try mlocking them, and
>> they actually must remain on CMA areas?
> 
> It should be safe to skip those. They belong to device and they
> shouldn't be affected by anything including getting swapped out.

Agreed. Only LRU folios are ever isolated for migration here
(isolate_folio_to_list() -> folio_isolate_lru()), and device-owned CMA
buffers are not on the LRU, so they are left in place. I'll double-check
the mmap paths and make sure this holds, and state it explicitly in v3.


Best regards,
Wandun

> 
> Sebastian

