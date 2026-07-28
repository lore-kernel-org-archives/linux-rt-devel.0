Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4791281369
	for <linux-rt-devel@lists.linux.dev>; Tue, 28 Jul 2026 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200459; cv=none; b=ja1O0ojlpxOF+FEMubD6V5f3zTXtxVBHqtLEGIxEXAlMdU+QE6FhtHKRa/xGqgyGEBrUjQTCy6BUDhRBMvoYO/rdzWYZY1yUEkuSwsYRDdSZ705bmAg988OB/Sj06MN6cInr8e6s2Ruo1rnyjhlin23pDDfXOkVj0NxiDCWiwL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200459; c=relaxed/simple;
	bh=Rv4a/ZwuMlprBGTkGl25aJZb/pq+nkMSU8+X4N67UUY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=R0l/bR3QWuUmELlRX7kxp6XlvvNA5oHwReRIWF4KdHWcbh24IHf9tfCKmr96YKbj2OtkftOabk19J4C+cPWs1kyLIaqo8hJllFPxTLT6gNvobrLMlW/vqX17NKs1hFpA2Wim8rdk8eiFBkeZrMnePmxbJ+lm9pKQ3H1GzFm6tnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=E1y4KqP7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="E1y4KqP7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so2845272b3a.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 27 Jul 2026 18:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785200457; x=1785805257; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SvwuWo6QBd0znbzB9xca22veiRMAvnRdnxWbmn1rCUk=;
        b=E1y4KqP7Txa7PzuMrJLtK+flOBu7ZA4cKmbX57Aa/O/9kiniVeB100kVY+ljz7q3Mf
         jsiwclfPl/nZvoF0bFmlnAJ2U0d85aRkkgk8MDgHcotzZVKUH7WWg9oa6iSW3Owpycd1
         ybYzv1WV1futtHJa5eQpFubJcF6V9QT2+Vkt4u+kkZnAH8MMCWU3sUVXHZX1/Y3K9Grl
         kYwAm1N+os+hwX2hJbdBzBcKYwQudsgAz87jAyWt4zJmKYFIqvGjYRLCofuYa5EQqc4b
         WkTU78Us0btlfNHePmAUEzCeW63oJ+auIG2Wc+i6OUcCpsFpNTKe+7RigbUjhkGaJRDy
         rSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785200457; x=1785805257;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SvwuWo6QBd0znbzB9xca22veiRMAvnRdnxWbmn1rCUk=;
        b=oOQ9XkFDMhtd3q/ffnc1RrGx7MFGXeh9YUtMqB9PTOBFXInoUCJ8ADIFDous1XOJjH
         OsOOqh9/kxc6Cz6XstUf6mcpbgI50TxYE4jTJF0YqjXQWUJa5DbyBuOAmv1ytkz7sDf2
         DKEl0/5U2dqt6LflqnCINI7oOm/Y2wPATsODKU3V+HtchsruXyAb1H47Ag7dVxuK56xr
         HWcz90PMxJHEmxSq1cw8uoWaVVQWkCVXXeVHNV1d+4CnvDUszC2V+zh8EmaGhzKvMniC
         nb9vRLwqQZ4rdxNw9zkSY285m8mtilQ7oQx2gUpFUJXTKlTgDPMeAQ9IppbSBvMb/EE+
         hmfw==
X-Gm-Message-State: AOJu0YzjxOO7FCr8X9VoP7Y/yOMYmhSMZKhPACFr+lBYRniNm1tnLZ19
	dr4SM9m9LSOt+Iz6lB7YCp0MiiigU0JU3sPHmNBuOhemyObHx7sR9MlkbvEp65mpHcY=
X-Gm-Gg: AR+sD130MzV8d5gVE5/Jdp6q+fOCQEvxU+5XzSpwfGMDnuQ06FZchPe+Vghyc4yJhb1
	O8Z1R8XVqHeIP5YQShmZrO759n3ITbLesNhWY3fx+sh4+OELrSSZtS5jXnK99lKQwKIb2eWuUdu
	ZkUGpqZE+eN0RqvgA+WDTyLsZ/WBaWjHsEchXNbCnzIrUJYvdIVFou7UJ69kvMop/S8ob+8I8vi
	lhbqkaBZsA/AkJRoZ4K2+lCBrWxFi5MvQt8/6zThUWHGB1wrg3ajYXOnosNieQLmx9XgmCkOqj0
	Xxqd42eitGnNObx0zCzWeEkSgZaMiN/5LUCckGBV2AMZ/E9I41kotguAUrUWDrHxlAwT86kM2cR
	drQ6/qMBC2t/p+KdtbRJt3dWuk6jwulbD/AdxpWAGTdDBWy6jdhD1ICufNEQglYWFJUi7ijZhEf
	jorOsxaID2bjLMsT8i5jtFXjJP+6BnkT4=
X-Received: by 2002:a05:6a00:1486:b0:845:c662:2be with SMTP id d2e1a72fcca58-84e932ee091mr202766b3a.42.1785200457053;
        Mon, 27 Jul 2026 18:00:57 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53258428sm3756444b3a.12.2026.07.27.18.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 18:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 21:00:55 -0400
Message-Id: <DK9SQVLBF4SG.2FDO076LD2E0M@etsalapatis.com>
Cc: <linux-rt-devel@lists.linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: arena: allocate the fault-in page
 outside the lock
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>,
 <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
 <20260727062521.376231-3-jiayuan.chen@linux.dev>
 <20260727064257.01BD81F000E9@smtp.kernel.org>
 <9a961b42-d095-4052-a749-dfabb9a45bf3@linux.dev>
In-Reply-To: <9a961b42-d095-4052-a749-dfabb9a45bf3@linux.dev>

On Mon Jul 27, 2026 at 4:00 AM EDT, Jiayuan Chen wrote:
>
> On 7/27/26 2:42 PM, sashiko-bot@kernel.org wrote:
> [...]
>>> @@ -489,55 +490,97 @@ static vm_fault_t arena_vm_fault(struct vm_fault =
*vmf)
>>>   	kbase =3D bpf_arena_get_kern_vm_start(arena);
>>>   	kaddr =3D kbase + (u32)(vmf->address);
>>>  =20
>>> -	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>>> +	page =3D vmalloc_to_page((void *)kaddr);
>>> +	if (!page) {
>>> +		/*
>>> +		 * Preallocate outside the lock so the allocation can sleep and go
>>> +		 * through reclaim (both memcg and global), the way do_anonymous_pag=
e()
>>> +		 * does. Under arena->spinlock only the non-blocking allocator is
>>> +		 * available, which never reclaims.
>>> +		 *
>>> +		 * This has to be the sleepable variant: VM_FAULT_OOM below is only
>>> +		 * meaningful if the OOM machinery was actually engaged. A failure
>>> +		 * from the non-blocking allocator engages nothing, so the fault
>>> +		 * would be retried forever.
>>> +		 */
>>> +		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>>> +		new_page =3D bpf_map_alloc_page_sleepable(map, NUMA_NO_NODE);
>> [Severity: High]
>> Is there a potential Denial of Service vector when BPF_F_SEGV_ON_FAULT i=
s set?
>>
>> This unconditionally preallocates a page using
>> bpf_map_alloc_page_sleepable() before checking the BPF_F_SEGV_ON_FAULT
>> flag later in the function.
>>
>> This allocation can block, trigger direct memory reclaim, and invoke the
>> OOM killer. Only after this expensive allocation does the code lock, che=
ck
>> the flag, return VM_FAULT_SIGSEGV, and discard the page.
>>
>> Could this allow an unprivileged user to force severe memory pressure by
>> repeatedly triggering page faults on unallocated addresses?
>
> Once VM_FAULT_SIGSEGV is returned, the process gets a SIGSEGV and by=20
> default is killed,
> so this isn't a realistic DoS.
>
> But, I think it's worth moving the "arena->map.map_flags &=20
> BPF_F_SEGV_ON_FAULT" check before the allocation.
>
>
>>> +		bpf_map_memcg_exit(old_memcg, new_memcg);
>>> +		if (!new_page)
>>> +			return VM_FAULT_OOM;
>>> +	}
>>> +
>>> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
>>>   		/* Make a reasonable effort to address impossible case */
>>> -		return VM_FAULT_RETRY;
>>> +		fault_ret =3D VM_FAULT_RETRY;
>>> +		goto out_err;
>>> +	}
>> [Severity: High]
>> This is a pre-existing issue, but does returning VM_FAULT_RETRY here
>> without releasing the fault lock cause a lock leak?
>>
>> The memory management subsystem strictly assumes the lock was released
>> if VM_FAULT_RETRY is returned. Retrying the fault will leak the read loc=
k
>> reference, and if any thread subsequently attempts to acquire the mmap_l=
ock
>> for writing, the system could permanently deadlock.
>
>
> Yes, it's true. arena_vm_fault() never touches mmap_lock, so returning=20
> VM_FAULT_RETRY violates the contract.
>
> '''
> do_user_addr_fault()
> {
>  =C2=A0 =C2=A0 fault =3D handle_mm_fault(...);=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 // call arena_vm_fault
>  =C2=A0 =C2=A0 ...
>  =C2=A0 =C2=A0 if (unlikely(fault & VM_FAULT_RETRY)) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D FAULT_FLAG_TRIED;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto retry;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // lock_mm_and_find_vma() will=20
> call mmap_read_lock again !
>  =C2=A0 =C2=A0 }
>  =C2=A0 =C2=A0 mmap_read_unlock(mm);
> }
> '''
>
> I think I should fix it as a separate patch with high priority ?

Please do, I think it makes sense as a separate patch targeting the
bpf tree while this patchset can keep targeting bpf-next.
