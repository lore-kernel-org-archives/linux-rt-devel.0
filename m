Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7606409E0A
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jul 2026 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597826; cv=none; b=BzKO9SK/Iehp1MtuuAQPxjoL//RD6jIYf+idVwgLPOMGjGKqGn7hHbPShtYOw4IWFaUxcuaJLECmHix2iDSCam9xLaQGdq3oUmvwKixBF7IFIrU74LGI7MISootXENSXHTYHw0FjFpfjvOJZdXAaSVPR+BUX8gqaVs8zNm94+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597826; c=relaxed/simple;
	bh=+4YqdlU9chWGVXpDNbvhimmUCWjFHgBWE8aKPUtH8rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvZdC3j9XZgSmX8DDTQwUXmtviiK4JpRdJ875lJU3zGtkr7ooUCcykn/oc6cguKny04N3Hl8z8vuCZhIIDLfO5MWw9MeT8kelTZzrcN9hndv6UKCIHIfbMOqh8kg1sPfUhiOp8gg/HodX49S9Z9PsOY3QGE4xzO0C0YzNfU7VDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vdql8KW3; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vdql8KW3"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ccb0e85312so11593255ad.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Jul 2026 04:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783597823; x=1784202623; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNCN2Fdr8yqkD0LsjJkDJLi2MeWHIGyOWfhBDBuuA2k=;
        b=Vdql8KW3pkVjN+B90SSvailYBSmXwFKBRJzEZeSh/YWRbNXxuMowR10Bfiydh4sf1U
         OwNZm2PTjbAIX5xWfU6JJpA60F+AkK3YZAEKWfWkmEhZWIv1QZwOFoJmh4iKIRFHTPWP
         rwh4xXA7S0sgy80PX/l1NEg3S93IfPiHrLLo3yYDUXS+gk6lNf3Sf0C+4hGGeYBcr0hE
         4yyPSMsukyLtDJZsiRal/sC5yCw35U6QxXGHs/R6nU89RNGUp1cicG4Ww2ZPt5Y8VZI4
         2a/rC+My574XlR55dd1q6YhfOPCF8ChK5r/vkqmYKg1MJGVczRaDfvIrR2qSYRNEV6px
         kUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783597823; x=1784202623;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hNCN2Fdr8yqkD0LsjJkDJLi2MeWHIGyOWfhBDBuuA2k=;
        b=Edog6bgVQyzMVDMeo0JPhb3MIPsf84FM+y9UsxltdQE+x28IxIL3brL+NM5GIgqvn5
         TpNuQq31YXWgBpBvgMQLtge/5HAfRHeHTuHTgAw9HIZCSl6rnNYupAs3xuQf9D1Kyen4
         k0Y77T1YGeNkHnM2bOjaYFTSRUC5JuDfNDP3wPTMpeGK1qAY6us2VzENQxmXjXbYXp/e
         cDZE2THe9TuJ+gEzWu+FuXXT5lvKs+RomrKoIABLbY6bYq78jhR4C89EwIRBeenE0Hyj
         L6R63xFOoCd2FPZ49ufQt4v3yUIBqTlVjWy+MdwyMq66Tqerja/j4K1OvBf2KqpHCeWg
         XcEg==
X-Forwarded-Encrypted: i=1; AHgh+RqcUhw9dVVILtpTSwRhzBHIrjrfaJYr+zaK+LgHu+ANdL+BRQzat7MJ+2/HMzBjhe7GerqRKMJ6CQDql8qgtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvkAbaTyJ9z46Wg30wbb0KhBUx2+5iaTwZfh80Bgomds9OQiXs
	qf1ifwDzSSdrE+eP6kkaiUsdxUzZ/X+iWh+q8zDXNe8rl6wcyV/dzkrh
X-Gm-Gg: AfdE7ckicIePEcpfYco4sY/31NDBGRCdDPk9lipNyxqGjoQaK2IPm+AVg0pmtBHChNw
	NvFJjy23DP2r5UsEsjHLk7wB0a3hKd9hCinFv9ibLC7HUbtykUxwmXdepJZ6ZEAApbxwHX/EDwW
	KYAHbi+RPeo5+uE6RqWsrJFtqAqALDbi96LoWgGn9BojoJxMsPNm/91k9UJ/oNYJuAyaCt+fYRl
	6M1cB/zX3M8RdOo20PlhVF6b5vPXp/Ncnt1PUvlxYeYYeyZG7mSZiMgANSGtOhPn+blbAPy38O9
	uFZhWWY4EA7likv5iWc0aTAd60tbtEdTVelqwsWXRLR7rEloD+H+hv8yfS6yq26I56e8Aw+8pzZ
	5O+w7uy+Bn+oxJpj/tNOANACuCjtb3DAFiKPye/o+KmHpE1nO3V6Vsw5LcPDHDaBSX4mdy4iWGK
	XdFl8NXGWO5n1ybpKDEkMp
X-Received: by 2002:a17:903:2b03:b0:2cc:f4d4:299f with SMTP id d9443c01a7336-2ccf4d46d5amr50430705ad.27.1783597822781;
        Thu, 09 Jul 2026 04:50:22 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb6e2sm43597885ad.3.2026.07.09.04.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:50:22 -0700 (PDT)
Message-ID: <66a0b183-825d-43e8-8a03-8ab98728c153@gmail.com>
Date: Thu, 9 Jul 2026 19:50:07 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/mlock: wait for migration to finish when
 mlocking a folio
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
 <20260707125925.3725177-3-chenwandun1@gmail.com> <ak0C-DP_1ZrTVSLj@lucifer>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <ak0C-DP_1ZrTVSLj@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/26 22:33, Lorenzo Stoakes wrote:
> On Tue, Jul 07, 2026 at 08:59:23PM +0800, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> In RT kernels, sysctl_compact_unevictable_allowed is false by default,
>> when the mlock/mlockall system call try to lock all the present page,
>> the mlock_pte_range function skips non-present entries. If these
>> non-present entries are migration entries, and the migration is not
>> guaranteed to have completed before the mlock/mlockall, it may result
>> in a page fault on subsequent access, which then waits for the
>> migration to finish, causing spike latency in RT kernels.
> 
> Is this really noticable and measurable?

Alexander Krabler reported a 1.1ms latency in [1]

https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/

> 
> I suppose not too many ranges should be mock
> 
>>
>> Fix it by waiting for the migration to complete during the mlock/mlockall
>> syscall when sysctl_compact_unevictable_allowed is false.
> 
> Probably better to reference the sysctl itself rather than an arbitrary varible
> name.
Got it.
> 
>>
>> Fixes: 90d07210ab55 ("mm: mlock: use folios and a folio batch internally")
> 
> Again I have no idea why you chose this as the fixes target, especially for
> this?
You're right, the Fixes tag was wrong.

Setting sysctl_compact_unevictable_allowed to zero was introduced in v5.7 by:
	commit 6923aa0d8c62 ("mm/compaction: Disable compact_unevictable_allowed on RT")

Before this commit, mlocked page can be migrated, and dont need to wait for
migration complete.

After this commit, if don't wait for migration complete, this may result in
latency spikes.

(The batch mlock feature increases the probability of hitting migration entries.)

Will update Fixes tag in next version.

> 
> But in any case, why is this separate from the previous commit? I sthis an
> entirely separate fix?

These two patches address two aspects of the same problem,
and I split them into separate patches mainly to make review easier.

Patch 1 mainly prevents pages to be migrated due to batch mlock;
patch 2 mainly ensures that pages undergoing migration have finished
migrating once the mlock system call completes.


> 
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> Link: https://lore.kernel.org/lkml/c8793c0f-7156-4cb7-9e6e-7909397e2fff@kernel.org/#t
> 
> A nit but please strip that #t.
Got it.
> 
>> ---
>>  mm/mlock.c | 23 +++++++++++++++++++++--
>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/mlock.c b/mm/mlock.c
>> index 97e49038d8d3..ac65de40b22b 100644
>> --- a/mm/mlock.c
>> +++ b/mm/mlock.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/memcontrol.h>
>>  #include <linux/mm_inline.h>
>>  #include <linux/secretmem.h>
>> +#include <linux/compaction.h>
>>
>>  #include "internal.h"
>>
>> @@ -361,8 +362,17 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
>>
>>  	ptl = pmd_trans_huge_lock(pmd, vma);
>>  	if (ptl) {
>> -		if (!pmd_present(*pmd))
>> +		if (!pmd_present(*pmd)) {
>> +			if (unlikely((vma->vm_flags & VM_LOCKED) &&
> 
> -> vma_test(vma, VMA_LOCKED_BIT)...
> 
> What is the basis for your unlikely()? Don't use likely()/unlikely() just
> because it feels right. Leave them out unless you have actual profiling data to
> prove it.
> 
> Remove it please.
Got it.
> 
> But I'm also confused here - why are you checking for VMAs that already had
> VMA_LOCKED_BIT set when you are about to set it?
> 
> Surely this shouldn't be predicated on VMA_LOCKED_BIT?
munlock also would call mlock_pte_range, if page is under undergoing migration,
munlock dont need to wait migration complete.

> 
> 
>> +			    !compaction_allow_unevictable() &&
> 
> Why do we care about compaction here? Are we assuming the softleaf migration
> entry is present only for compaction reasons?
> 
> So these migration entries could be there for any reason? Does it matter? Is it
> such a big deal, on mlock, to wait for migration entries? I think probably not.
> 
> But then maybe some weird workload gets affected... hmm.

Indeed, there are workloads that are affected by this.
In RT kernels, RT processes typically use mlock to prevent their memory from
being swapped out, and sysctl_compact_unevictable_is set to default 0 in the
RT kernels, so mlocked memory won't be migrated and won't encounter migration
entries on access.

Using compaction_allow_unevictable here is mainly to check whether the system
is latency-sensitive. In RT kernels, sysctl_compact_unevictable_is set to 0 by
default.

If there is no waiting, the migration may won't have completed by the time of
the subsequent memory access, and then we would have to wait for migration
to finish in the page fault path. Since pmd_migration_entry_wait/migration_entry_wait
has no priority-propagation mechanism, if the process executing mlock is an
RT process, this can lead to priority inversion and latency spike occurs.

> 
>> +			    softleaf_is_migration(softleaf_from_pmd(*pmd)))) {
> 
> Use pmd_is_migration_entry()? :)
Got it.
> 
> And technically you should use pmdp_get() I think? Maybe a situation where we
> don't care/need the READ_ONCE() though.
> 
>> +				spin_unlock(ptl);
>> +				pmd_migration_entry_wait(vma->vm_mm, pmd);
>> +				walk->action = ACTION_AGAIN;
>> +				return 0;
>> +			}
> 
> This code is really disgusting, let's please not just copy/paste open-coded
> nested horror shows like this.
> 
> A good rule of thumb is if you see a bunch of code 'poking out' like this and
> certainly if you copy/paste it or something very much like it, break it out into
> a function.
Got it, will do in next version.
> 
> So:
> 
> static bool wait_for_migration(const struct vm_area_struct *vma, softleaf_t entry)
> {
>>>>> As above I'm not sure should even be checking this?
> 	if (!vma_test(vma, VMA_LOCKED_BIT))
> 		return false;
>>>>> As above I'm not sure this makes sense?
> 	if (compaction_allowed_unevictable())
> 		return false;
> 
> 	return softleaf_is_migration(entry);
> }
> 
> Then call it like:
> 
> 	if (ptl) {
> 		const pmd_t pmd = pmdp_get(pmd);
> 
> 		if (!pmd_present(pmd)) {
> 			const softleaf_t entry = softleaf_from_pmd(pmd);
> 
> 			if (!wait_for_migration(vma, entry))
> 				goto out;
> 
> 			spin_unlock(ptl);
> 			pmd_migration_entry_wait(vma->vm_mm, pmd);
> 			walk->action = ACTION_AGAIN;
> 			return 0;
> 		}
> 		if (is_huge_zero_pmd(pmd))
> 			goto out;
> 
> (etc. going *pmd -> pmd)
> 
> But we could probably do even better than that, and assuming your dubious checks
> above aren't needed, we don't even need a helper then:
> 
> 	if (ptl) {
> 		const pmd_t pmd = pmdp_get(pmd); // possibly just *pmd?
> 		const softleaf_t entry = softleaf_from_pmd(pmd);
> 
> 		if (softleaf_is_migration(entry)) {
> 			/* Wait for migration entries. */
> 			spin_unlock(ptl);
> 			pmd_migration_entry_wait(vma->vm_mm, pmd);
> 			walk->action = ACTION_AGAIN;
> 			return 0;
> 		}
> 		if (!pmd_present(pmd))
> 			goto out;
> 		etc.
> 
> And similar for the PTE stuff below.
> 
> This works because softleaf_from_pmd() (and pte) will give you a 'none' softleaf
> if the entry is not a softlaf entry. So you can unconditionally call it on a
> PMD.
Got it.
> 
>>  			goto out;
>> +		}
>>  		if (is_huge_zero_pmd(*pmd))
>>  			goto out;
>>  		folio = pmd_folio(*pmd);
>> @@ -383,8 +393,17 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
>>
>>  	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
>>  		ptent = ptep_get(pte);
>> -		if (!pte_present(ptent))
>> +		if (!pte_present(ptent)) {
>> +			if (unlikely((vma->vm_flags & VM_LOCKED) &&
>> +			    !compaction_allow_unevictable() &&
>> +			    softleaf_is_migration(softleaf_from_pte(ptent)))) {
>> +				pte_unmap_unlock(start_pte, ptl);
>> +				migration_entry_wait(vma->vm_mm, pmd, addr);
>> +				walk->action = ACTION_AGAIN;
>> +				return 0;
>> +			}
>>  			continue;
>> +		}
>>  		folio = vm_normal_folio(vma, addr, ptent);
>>  		if (!folio || folio_is_zone_device(folio))
>>  			continue;
>> --
>> 2.43.0
>>
> 
> Thanks, Lorenzo

Thanks again.
Wandun
