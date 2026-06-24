Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86CC2E8DEB
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299300; cv=none; b=vFiSuxFz2xZEPQguc1OAXUC/HNlBVqrOo/tpKb88TtDCVZ3eTxUzLIzqEQXMI1OI4pDVjrVyEWTklY9fzqqfotvNqqSDkV2QCHx7cbmpXv/wXqXaA8RkIrLkAjEbBibHcQH7dOn+8/5U5XJSBMvOtrAW3uLNJldygL+7kIC3zbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299300; c=relaxed/simple;
	bh=IoBEiolJATWxZV1vpooXXrlpswz8LM+XlrdVTKXE2U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWGiQIid1NNxtVBeXM5Ge8rJGpYhpbyJbRGAQWbur3KX9xWM/dst3P3bxpL8JMlUMF1hccCotn8XAefSJ58lCZt6/MQyCTBUA+YoSTl4g4d+vHCGP/XU7Qq/XmbabDLCicsy2l3luzMHuli6uKZ3N7slJwr8cCHiMd7uaCm3hTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Agcj0tXi; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Agcj0tXi"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-8424b00710aso680448b3a.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782299297; x=1782904097; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXtuRuNUX2Rp2ayyKmvIq6nuFd+B5mhsEfkXh3sxMRw=;
        b=Agcj0tXiomGusq3BqtVuYJJtmnypg75IqEwcV3HbNr0Lnfl2PNaU7cnvauSMcmNGqJ
         UH1bPncfjj50exFK98RYvOlYI1+SC8pUsKTrUZEvBNjo52GwVplfrlq8OZufuMARrcpY
         5xSGuRJZRdTWSmgZPAU6nh7Ew0zN6BDKkzjpJ4zK8qkeI0E2Wl/Jc4W1IKnFYXmTfzUs
         mnj0/2Ejv/7kVXDZ1I/3KuYXvs4tMqhRrp+dcsUdIOUbT/i6ji3L+FTYgypRpmI/Gjrp
         wFdmqTxx6oK5rzDfeHrDfUD+VVc9qxasY/j6Hemot3hWW07ZAk8RVEq29msvwa83UaYT
         QkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782299297; x=1782904097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXtuRuNUX2Rp2ayyKmvIq6nuFd+B5mhsEfkXh3sxMRw=;
        b=ZPJrWwjbKr21HqionUzSayVuGs9tBU2ax2SbW4nXp+pYLVOKNp5i11rASSKC0ufAbm
         ogX2oq6AoseuUSQH5QUUJy8XfSj+KvWIMOA05z+4tTS+cmRxztfncaLF3zSsS1dlXjbr
         0OcztM3kTtKNpVMfYFBbBsOOVF9KQeSVI6ADajXlUD1Kdex+D9NJ96qvISVDCvwS5RnZ
         kW38m1h9g2C8LRysVOV/l3xLof/NvdaD3Y4aH+RgH4F4OqK7ChVAcoiFGsUzS+yAbx9u
         la7tRzIyxKQHHCMlQvc58AvazT3kvZ3lD3gMLsiNAyrFFm5NvnsLjxNYhM3lVo0zhYPD
         Gl5g==
X-Forwarded-Encrypted: i=1; AFNElJ+4WeUud1W2ohyIzrY+c77syHp3uDal28eZOZUsOZoRXnQ6ZIOIEaV5dQrgq9xmvYvR+qQK8nVtX1cZSHuDGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyE+2d10h/01QrroF76g4pPNbm7twtNu+LIOxlsxDgoeeOZ/c7n
	WAHf3b4D3pxT3gCLl+jQiZbvZwbSH3N1pdpH0IDPacnXks5W9hQVCoLd
X-Gm-Gg: AfdE7cmvDh+ZBJot7AbmLdlV+JBkp/9m3dmaPYPC84AOe61huS7FQGXMhSMAzzvfyXV
	gH7rwaE4hn0deNEUn1zJulq4lkAviDsKYKX5/IZYvC5k70BBJmZ9qohX15SnterffDxYC2+0ADT
	SfUqJSno5SbYLSm2ug+VJmwNWuJzmY3r2L0FIoILzrPAuTKRWGgeZFToLCMCPohdB5kyFHU7q5i
	hQY9ysRjXMkuHqIDdghmiPClHUZYswj91MpuRMflSoWv3i3vR8gY3Z8X2+aGAc17b21Z63W8zlE
	5Mqu0VnX6U48QCwdfu9OZx3D0xvHFSyLU/3uXUNJFH32wWe1w0syX/Zs/9nMcgKs6s05lpHdSvn
	BeSiPc8j7LJsnqU/stygHyXe4kdWcEhAGeW9ufoXvMats6DjVClQFq1y6a0DyiabWB4toTxiqNf
	geCeYziTAg9GV0MyBq+OFx
X-Received: by 2002:a05:6a00:a112:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-845a2ae22e4mr3475551b3a.13.1782299296908;
        Wed, 24 Jun 2026 04:08:16 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a4002c51sm1926735b3a.27.2026.06.24.04.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 04:08:15 -0700 (PDT)
Message-ID: <ca1115c0-1509-453a-8235-08e381a3da6f@gmail.com>
Date: Wed, 24 Jun 2026 19:08:06 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, rppt@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, Alexander.Krabler@kuka.com,
 Hugh Dickins <hughd@google.com>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-2-chenwandun1@gmail.com>
 <969cb14b-5b8b-48e6-add6-4dd13101dd89@kernel.org>
 <040788a9-e0d5-478e-bb48-3d22b8b41020@gmail.com>
 <c8793c0f-7156-4cb7-9e6e-7909397e2fff@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <c8793c0f-7156-4cb7-9e6e-7909397e2fff@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/22/26 17:55, Vlastimil Babka (SUSE) wrote:
> On 6/18/26 13:43, Wandun wrote:
>>
>>
>> On 6/18/26 02:52, Vlastimil Babka (SUSE) wrote:
>>> On 6/4/26 04:38, Wandun Chen wrote:
>>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>>
>>>> compact_unevictable_allowed is default 0 under PREEMPT_RT,
>>>> isolate_migratepages_block() skips folios with PG_unevictable set.
>>>> However, mlock_folio() sets PG_mlocked immediately but defers
>>>> PG_unevictable to mlock_folio_batch(), result in a folio with
>>>> PG_mlocked=1 but PG_unevictable=0. Compaction will isolate such a
>>>> folio.
>>>>
>>>> Fix by checking folio_test_mlocked() together with the existing
>>>> folio_test_unevictable() check.
>>>>
>>>> A similar issue has been reported by Alexander Krabler on a 6.12-rt
>>>> aarch64 system. Vlastimil suggested to check the mlocked flag [1].
>>>>
>>>> Reported-by: Alexander Krabler <Alexander.Krabler@kuka.com>
>>>> Closes: https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/
>>>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>>>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>>>> Link: https://lore.kernel.org/all/33275585-f2db-4779-89f0-3ae24b455a67@suse.cz/ [1]
>>>
>>> Well in that thread, Hugh doubted my suggestion and then it seems we didn't
>>> concluded anything. Did you actually in practice observe the issue that
>>> Alexander had, and that this patch fixed it, or is that theoretical?
>>>
>> Yes, I wrote a test case that can reproduce it in a few second.
>>
>> The test case contains 3 steps:
>> 1. mlockall
>> 2. mmap file(2GB) + trigger file write page fault;
>> 3. during step 1, trigger compact via /proc/sys/vm/compact_memory
>>
>>
>> My reproduction environment is qemu with 4GB ram, 8 core, aarch64,
>> preempt_rt and includes the tracepoint in patch 02.
>> After running the reproduction program for a few seconds, the
>> following output appears.
> 
> Ah, nice.
> 
>> repro-403     [004] ....1   101.270505: mm_compaction_isolate_folio: pfn=0x71e3a mode=0x0 flags=referenced|uptodate|mlocked
>> repro-403     [004] ....1   101.270507: mm_compaction_isolate_folio: pfn=0x71e3b mode=0x0 flags=referenced|uptodate|mlocked
>> repro-403     [004] ....1   101.270513: mm_compaction_isolate_folio: pfn=0x71e3c mode=0x0 flags=referenced|uptodate|mlocked
>> repro-403     [004] ....1   101.270515: mm_compaction_isolate_folio: pfn=0x71e3d mode=0x0 flags=uptodate|mlocked
>> repro-403     [004] ....1   101.270517: mm_compaction_isolate_folio: pfn=0x71e3e mode=0x0 flags=uptodate|mlocked
>> repro-403     [004] ....1   101.270520: mm_compaction_isolate_folio: pfn=0x71e3f mode=0x0 flags=uptodate|mlocked
>>
>>
>> Unfortunately, I recently found that there is still a bug in the
>> fix patch. Setting mlocked in the mlock_folio function could happen
>> even after the page is successfully isolated, so it still cannot
>> prevent migration. Because of this, I need to think more about how
>> to fix it.
>>
>> Perhaps we should double-check whether the page is mlocked during
>> the actual migration phase.
> 
> So IIUC the isolation+migration might be started between the folio is
> allocated, and mlocked? In that case the check during migration could still

Yes, in that case it still be racy, it is not a good idea to check page flags.

> be racy, and if the page is isolated, it's already bad for the RT process.

IIUC, more accurately, the migration entry in the page talbe is real a bad for
RT process, because isolate page doesn't modify the page table, so memory
access continues as usual, therefore a new idea occur.

S1. In the mlock[all] syscall, if mlock_vma_pages_range hit a migration entry,
    then, it should wait for the migration to complete.

S2. During the unmap phase of memory migration, prevent a page from being unmapped
    if the page's associated vma is markd with VM_LOCKED, similar to how reclaim is
    disabled for pages in a VM_LOCKED vma(try_to_unmap_one).


For a page handled during the mlock[all] syscall:
  - if migration has been already finished, there is noting to do;
  - if migration is in progress and the migration etnry is already filled, we
    wait (S1)
  - if the page is in-fight, going to be isolated/migrated, S2 prevents the unmap.

For a page handled during a page fault: VM_LOCKED is already set on the vma,
so S2 guarantees it will not be unmapped, hence no migration entry.


Thanks a lot for the detailed feedback, Vlastimil.

Best regards,
Wandun


> 
> So this would only be a short-term problem after the mlockall, but we don't
> have a way for the RT process to know the moment it's all settled, right?

Yes, some pages may have been isolated and will do migration.

> Probably the proper solution would be for mlock[all]() itself to wait for an
> isolated page, and only continue once it knows it can't be isolated anymore.
> This might howver would go against some of the folio batching optimizations?
> 
>> What do you think of this best-effort approach?
>>
>>
>> Best regards,
>> Wandun
>>
>>
>>
>>
>>
>> The full reproducer is as below:
>>
>> /* gcc repro.c -o repro -lpthread */
>>
>> #define _GNU_SOURCE
>> #include <fcntl.h>
>> #include <pthread.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <sys/mman.h>
>> #include <unistd.h>
>>
>> #define PAGE_SIZE       4096
>> #define NR_PAGES        32
>> #define FILE_SIZE       (2ULL * 1024 * 1024 * 1024)
>>
>> static void *worker_fn(void *arg)
>> {
>> 	int fd = (long)arg;
>> 	size_t len = (size_t)FILE_SIZE;
>> 	char *p = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>> 	if (p == MAP_FAILED)
>> 		return NULL;
>>
>> 	for (size_t off = 0; off + NR_PAGES * PAGE_SIZE <= len;
>> 	     off += NR_PAGES * PAGE_SIZE) {
>> 		for (int i = 0; i < NR_PAGES; i++)
>> 			p[off + i * PAGE_SIZE] = 1;
>> 		usleep(200);
>> 	}
>>
>> 	munmap(p, len);
>> 	return NULL;
>> }
>>
>> static void *compact_fn(void *arg)
>> {
>> 	(void)arg;
>> 	int fd = open("/proc/sys/vm/compact_memory", O_WRONLY);
>> 	if (fd < 0)
>> 		return NULL;
>>
>> 	while (1) {
>> 		if (write(fd, "1", 1) < 0) {}
>> 		usleep(5000);
>> 	}
>> }
>>
>> int main(void)
>> {
>> 	mlockall(MCL_CURRENT | MCL_FUTURE);
>>
>> 	int fd = open("./repro_largefile.dat", O_RDWR | O_CREAT, 0600);
>> 	if (fd < 0)
>> 		return 1;
>> 	unlink("./repro_largefile.dat");
>> 	if (ftruncate(fd, (off_t)FILE_SIZE) < 0)
>> 		return 1;
>>
>> 	printf("repro_largefile: 1 worker, %d pages/batch, Ctrl-C to stop\n",
>> 	       NR_PAGES);
>>
>> 	pthread_t compact, worker;
>> 	pthread_create(&compact, NULL, compact_fn, NULL);
>> 	pthread_create(&worker, NULL, worker_fn, (void *)(long)fd);
>>
>> 	pthread_join(worker, NULL);
>> 	return 0;
>> }
>>
>>>> ---
>>>>  mm/compaction.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>> index b776f35ad020..7e07b792bcb5 100644
>>>> --- a/mm/compaction.c
>>>> +++ b/mm/compaction.c
>>>> @@ -1116,7 +1116,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>>>  		is_unevictable = folio_test_unevictable(folio);
>>>>  
>>>>  		/* Compaction might skip unevictable pages but CMA takes them */
>>>> -		if (!(mode & ISOLATE_UNEVICTABLE) && is_unevictable)
>>>> +		if (!(mode & ISOLATE_UNEVICTABLE) &&
>>>> +		    (is_unevictable || folio_test_mlocked(folio)))
>>>>  			goto isolate_fail_put;
>>>>  
>>>>  		/*
>>>
>>
> 

