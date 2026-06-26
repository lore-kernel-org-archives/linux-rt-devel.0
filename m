Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8C3EB0E3
	for <linux-rt-devel@lists.linux.dev>; Fri, 26 Jun 2026 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466711; cv=none; b=NgIZP4mV0E6p8eg39e/8pNV1q+RjPoSJxV56kdpxhzXJYn7vIp6ZGCC3zkn1I2MABlxz7yt3TSm/0a37h7Ae0xxNP0Dpybwo6DwL41sns5BXKyBToNWQi4N+N3Kor14btMkgVZATw/NK9U2LNiKR/hRMWi86clE9T/ggWOO6SYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466711; c=relaxed/simple;
	bh=+S+m7apAxbJqEgKOiJU8zn2xYNA4jatMiM0KmVPA2b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huyhnOIQ+KGYNFMhuNNvmriYcV7YJa7TOnPNl5ZQ3xVDYjh8ri4ub9uvzTI8rGVyK9Qj4LzY8p6B6nJQyWfxEIhEV/sjqYq9fx51YylzJKMp0ZtJNz4G9VW2SiJJui8fInwltsXlG4v3ZC/hGxl6VDojkJpTHH5L0OskZR9ILGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkjxYgFE; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkjxYgFE"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-37df72f4705so535739a91.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 26 Jun 2026 02:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782466707; x=1783071507; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmGOCogUDtb4VYXfazs9AlgEqBwqwIaiss/qmncz56U=;
        b=gkjxYgFE/h28Y7YeBzJ0BHE2AaIMz4DZS3wR2gKeN3bRmQnSPRNjrsUcpMiGte/a0Q
         8mnY4ZB1EQZMWjA+MJfmKEjfNAMmNzx0KXxwB0diaMIqgBZSXlqsL4t0P9fPAw26p5Di
         G6K1M/f2WJ60n0tf+DQhkNEkuoBqV41QbcNwABQtn1Wwo5Dd6iSLMgNoscPz6t6h1uld
         XXlrvugDuNBebTiIbmOrvZ7Prtr6QOFVi9rvpKDU7mA3JIXguP3ghuN0jHmPXAVI0Asy
         OcaQQEQDfpW+Xc6slAMzNsfaNh1YeAOks+0qp6P1WLjxvjXKz1D+oLvO5zdp+6a6c2kv
         rrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466707; x=1783071507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmGOCogUDtb4VYXfazs9AlgEqBwqwIaiss/qmncz56U=;
        b=Fs9qc4NoRgBjAGePF5ZWEboYTRUpQOLtCHCea0b7zY/OudbsjQJzRQVLSrBJtJ1EG3
         JgSKaH1+XQddGrwCTCS2HPOIVMuAf1VhuGFUNrg/XdBjlZLHEnqfejL98EHDuPH+rL50
         mfBumceGMGYKpDzuSCgAs5isdP/WY2fnA+POeEZObFLpK82AYZF6Rac6a/Ztu7EGDTz7
         IIeDTmvUKaK9V0nKp80aeAECbjoOvEijgd+/IMb7vxNVtpFvGZDmp10LLfSe6imuZGGz
         Prmn8aW9Z1SFEL9fw9baleC+DQH8VURwSByxexMBo3BBeK4uofaFbGVMWyu8wAl9186E
         t6Sg==
X-Forwarded-Encrypted: i=1; AFNElJ89+oFkQlr8Tja5XJnOmDxERdnmnPGyQ8rRUoQQZ5cySizlqyIlJqdFL6HiIP14mHnZFPo0oTOVwxdGsfRcRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuEVCASbLzvDRbc8yJi00LUNqd8exiF9pOqBnPUEoqh5d4rWIE
	3QYc/Lz5Dnw1kUejq4D92IhpWDl/q0zzzTXiBe66zwMuPhL7/ZgCfmhL
X-Gm-Gg: AfdE7clItcFST4spsvBUx7FVyWwkt1/5Sk+fjegvkNC9GBGN23e2uIgwDRbVAm/C7HX
	iEMB/BuBeJuv/HZfeLhg8RYqP653FVQNl4MwQuBU/nPpYrrAzipzQ/28HDWWBya1G1CEcvH4Xmx
	I4iq5mHNbE0ePJOYLKOObU31A+Yr28JI9wKpgtbMXA+9vJOe6hodt7sIl7/8wFZuMn4tqLWiOCU
	qK4lvgosu7LqWs7uPuH/ZRJYh5Y2SIZ4T79FXPy8HZQG1cB0udClTG2XU2JpSwIxPQyvPAyzl6P
	P5efJxAV0wIid3eD3t6slaZKJaYy2MTBgWL2qJZTTt6jk0WQkyx4ftN0Y2v53lnHL2KNK4qLPpG
	zgipUMDjaiRymDsOZzKO7QYS/eG80pnUZWYn6oBm6V1NbqS4zB0XyR4YA9fWfjCboOCk4TTe3A3
	o/osuORnJZidfN9OkgZYbE
X-Received: by 2002:a05:6a20:7f8d:b0:3b7:aefe:4367 with SMTP id adf61e73a8af0-3bd4af031e2mr7074117637.33.1782466706836;
        Fri, 26 Jun 2026 02:38:26 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bcb9b749sm3025866a12.23.2026.06.26.02.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 02:38:26 -0700 (PDT)
Message-ID: <a96b0b24-c405-43c4-96ef-605bacd17cad@gmail.com>
Date: Fri, 26 Jun 2026 17:38:17 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
To: Alexander Krabler <Alexander.Krabler@kuka.com>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
 <mhocko@suse.com>, "jackmanb@google.com" <jackmanb@google.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "david@kernel.org" <david@kernel.org>, "ljs@kernel.org" <ljs@kernel.org>,
 "liam@infradead.org" <liam@infradead.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 "clrkwllms@kernel.org" <clrkwllms@kernel.org>,
 Hugh Dickins <hughd@google.com>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-2-chenwandun1@gmail.com>
 <969cb14b-5b8b-48e6-add6-4dd13101dd89@kernel.org>
 <040788a9-e0d5-478e-bb48-3d22b8b41020@gmail.com>
 <c8793c0f-7156-4cb7-9e6e-7909397e2fff@kernel.org>
 <ca1115c0-1509-453a-8235-08e381a3da6f@gmail.com>
 <PR3PR01MB6666C11E08516555C153D4FD82EB2@PR3PR01MB6666.eurprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <PR3PR01MB6666C11E08516555C153D4FD82EB2@PR3PR01MB6666.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/26/26 16:45, Alexander Krabler wrote:
> On 6/24/26 13:08, Wandun wrote:
>> On 6/22/26 17:55, Vlastimil Babka (SUSE) wrote:
>>> On 6/18/26 13:43, Wandun wrote:
>>>> Yes, I wrote a test case that can reproduce it in a few second.
>>>>
>>>> The test case contains 3 steps:
>>>> 1. mlockall
>>>> 2. mmap file(2GB) + trigger file write page fault;
>>>> 3. during step 1, trigger compact via /proc/sys/vm/compact_memory
>>>>
>>>>
>>>> My reproduction environment is qemu with 4GB ram, 8 core, aarch64,
>>>> preempt_rt and includes the tracepoint in patch 02.
>>>> After running the reproduction program for a few seconds, the
>>>> following output appears.
>>>>
>>>> repro-403     [004] ....1   101.270505: mm_compaction_isolate_folio: pfn=0x71e3a mode=0x0
>> flags=referenced|uptodate|mlocked
>>>> repro-403     [004] ....1   101.270507: mm_compaction_isolate_folio: pfn=0x71e3b mode=0x0
>> flags=referenced|uptodate|mlocked
>>>> repro-403     [004] ....1   101.270513: mm_compaction_isolate_folio: pfn=0x71e3c mode=0x0
>> flags=referenced|uptodate|mlocked
>>>> repro-403     [004] ....1   101.270515: mm_compaction_isolate_folio: pfn=0x71e3d mode=0x0
>> flags=uptodate|mlocked
>>>> repro-403     [004] ....1   101.270517: mm_compaction_isolate_folio: pfn=0x71e3e mode=0x0
>> flags=uptodate|mlocked
>>>> repro-403     [004] ....1   101.270520: mm_compaction_isolate_folio: pfn=0x71e3f mode=0x0
>> flags=uptodate|mlocked
> 
> I applied your PATCH 2/3 to our kernel and checked with your reproducer,
> I get similar output, e.g.
> t_compact-2148    [005] ....1   515.320221: mm_compaction_isolate_folio: pfn=0xe66c2 mode=0x0
>                                             flags=referenced|uptodate|active|swapbacked|mlocked
> 
> With your first patch applied, the amount of these messages decrease.

Parts of mlocked but not unevictable pages has been filter out, so
messages decrease, but racy is still there.

> I was not able to apply your third patch to our (older) kernel.

Patch 3 is meaningless to you. The problem in your report is caused by kcompactd,
not cma alloc, so it is of no use to you.

> 
> However, we were not able to reproduce the actual race
> (mlockall() process waiting on a migration PTE),
> not in the past, not now. Might be hard to trigger that race.

Not hard to trigger that case, I added a debug message, such as below,
lots of messages occur in a few second.

diff --cc mm/memory.c
index ff338c2abe92,ff338c2abe92..6552b3b14f78
--- a/mm/memory.c
+++ b/mm/memory.c
@@@ -4768,6 -4768,6 +4768,8 @@@ vm_fault_t do_swap_page(struct vm_faul
                if (softleaf_is_migration(entry)) {
                        migration_entry_wait(vma->vm_mm, vmf->pmd,
                                             vmf->address);
+                       if (!strcmp(current->comm, "repro"))
+                               pr_err("============== hit ================\n");
                } else if (softleaf_is_device_exclusive(entry)) {
                        vmf->page = softleaf_to_page(entry);
                        ret = remove_device_exclusive_entry(vmf);

Best regard,
Wandun

> 
>> IIUC, more accurately, the migration entry in the page talbe is real a bad for
>> RT process, because isolate page doesn't modify the page table, so memory
>> access continues as usual, therefore a new idea occur.
>>
>> S1. In the mlock[all] syscall, if mlock_vma_pages_range hit a migration entry,
>>     then, it should wait for the migration to complete.
>>
>> S2. During the unmap phase of memory migration, prevent a page from being unmapped
>>     if the page's associated vma is markd with VM_LOCKED, similar to how reclaim is
>>     disabled for pages in a VM_LOCKED vma(try_to_unmap_one).
>>
>>
>> For a page handled during the mlock[all] syscall:
>>   - if migration has been already finished, there is noting to do;
>>   - if migration is in progress and the migration etnry is already filled, we
>>     wait (S1)
>>   - if the page is in-fight, going to be isolated/migrated, S2 prevents the unmap.
>>
>> For a page handled during a page fault: VM_LOCKED is already set on the vma,
>> so S2 guarantees it will not be unmapped, hence no migration entry.
> 
> I do not understand all details of this, but it looks good,
> especially the S1 case makes a lot of sense for me.
> 
> Nitpick: I suggest to switch order of PATCH 1 and 2 for the next iteration,
> introducing the tracepoint first and then improve the situation.
> 
> Thanks a lot for looking into this issue!
> 
> Best regards,
> Alexander
> 
> --
> 
> KUKA Deutschland GmbH   Board of Directors: Michael Jürgens (Chairman), Johan Naten, Hui Zhang   Registered Office: Augsburg HRB 14914
> 
> This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and destroy this e-mail. Any unauthorized copying, disclosure or distribution of contents of this e-mail is strictly forbidden.
> 
> Please consider the environment before printing this e-mail.

