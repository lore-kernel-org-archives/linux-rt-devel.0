Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199F371867
	for <linux-rt-devel@lists.linux.dev>; Tue, 14 Jul 2026 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993518; cv=none; b=kibHlQAAe+PJZPmegAdYYuVaRJnb9tW2JL3IePPWnvECtjPKJQqoiTJc0zZIT00QFu/uxvB7qQvz+BRlIf86aJcQ32DN02iAxn0fXFdtFHY9BZvfsMYRqzdvgIQIuDPe99l1PNhcb5eDoCT/i9wPFogoAoplo2jaA0IL/bTlS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993518; c=relaxed/simple;
	bh=okAnVsVly5jc+yei4Wz48daP/zuQ/yq+djt9pIOtyYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p03MCaKLzfzW0tKEcJl23f7gqLK3P5liksqw5/uMv0RFLlLmSZ8DQLnNWB8dSdFBnFp7T6kux9xUZgKJHJpA4f+AHVuJn+oTDDEZV1X+VgCVmpyyMcSM49ocfhroYrbmVwCCftDLXMmLrpwvXMwDPk7JZGLeCbiPH5dGFoC3zFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kvyn5KIO; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvyn5KIO"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cad1448ddcso31479455ad.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 18:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783993516; x=1784598316; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=73xB3qrx3acG77JE8xn8xw37lKaovvRLQMvPzLm4bDo=;
        b=Kvyn5KIO0nnpbDBiATrs9QzfZhlo9AUIJDkFwsYESMkZt+QS+7Crb1EqP5pXe3QpS/
         cWtgF8LaeFvo0ITFgGsfsDMqOarB+J7iX0mh1GIYL/1cbXMDwaCnW2sb5iwnCSFxS73H
         5FVmactmLmFUoirP3DQLX2xfcNSFeDujjrx0cG3o+G1E0dFNz/rEU4a+cJAENURUATeJ
         fTqRq7U+xupXX9gtHcnurMpgWIpRpaiZZQgtvK83E36aWLgQRW79aVNpffN2yPE5LIMn
         oM3oMNZk7+5FN82oOXRJ7BQOef1VUBF5JP6Q5LEMdGOo6DbIaYLeCWobJc8GHs4B16s9
         21ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783993516; x=1784598316;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=73xB3qrx3acG77JE8xn8xw37lKaovvRLQMvPzLm4bDo=;
        b=Kq+MJZrgkTovR/QGYZfG2Wn9z/Y+goR5pETVmPjyZgOUqWGuiB10ARKW3FVrUmhc58
         MsEfl0fOWxr21wqbgKnPfMOLMI+dn0iFaUDUDE1BhH74DWD/ac1/YBeaP6lWmTIhqY77
         f372tz0CjIAR2ZsenTzg6JzyWtw3UGxOEY+9yOIH+x/IU0lwp3lW4quqiU9/wp3y+lBF
         SG3WEpfR0px3IKMIFoM13PGHUxx5vSp9rBnvksSFAcwGdt7rXUcOg0GAORJjszX+SD3P
         8zrUqzE4FHneHvgWUwKLUBtXappJuWQ5odDC3d+60xjric4d0c0d5aAmZ2XjczqLZyEE
         eZkA==
X-Forwarded-Encrypted: i=1; AHgh+RoxsieW8SsWIZdMLEZgxt6wBo0s3mutA2E8jLHEYNp2Wbz9gCLFUbPTKGiH9eBsZUlkHUR9TA//psgRE6+/Gw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4wp+XohiET6EWRmBu0tE54YiiupfrV3nk3vm9N2F2NZQegVd0
	MzTx6samzRvFXmyRSftFPs3UFBxkAipmRGGNZ/sQ4QUoqp8iymv3Fboh
X-Gm-Gg: AfdE7cm2r3hiMK1lTuXeM5Suj5irWlhYi4opvPbZlX8S2d2iu9et3SvkDdzvLTJhrbp
	O1+PqubtSbamlK83+7fk4yDzl4x22uTQon7DpNawsecHgHRPNQJnrg3yXELtobkfFEQPq1m2Xjr
	NywMx0ute1d+mjrqGM/khKcj/vfJK11Q0COTbwmAsU7sQYUM4XkWad62zNtt4jRDS5OPhoahVtP
	oFBCF3a2TQPF5r/lm/6CdMCTj6D3PcffZzmlS6hLovlYbXArVTHe1ct5qFL+ErpD2nS2eYQW1iy
	3QaSZcUP8UWcOXAnLk50Mvw4R3C+e67uAhBDuuTdzT3fy4xJl9GDBedFkmE5R8HDBffIsKy+95a
	QYBfmvTO38sb9tVuHpX4PzHJh08hL1hTQDJZoOGAoi3HAaCL0S2ViTzBe4ATki8aCjExZXDpYzO
	dF1SfKnHKv4uaHMeZRP4r2
X-Received: by 2002:a17:903:3205:b0:2c7:f4bd:91b5 with SMTP id d9443c01a7336-2cee98446f9mr17408505ad.0.1783993516159;
        Mon, 13 Jul 2026 18:45:16 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb86bsm107793465ad.11.2026.07.13.18.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 18:45:15 -0700 (PDT)
Message-ID: <97c1dccb-8f17-45f3-8058-023da96620c8@gmail.com>
Date: Tue, 14 Jul 2026 09:45:01 +0800
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
 <ak0EsCeucJarlI7G@lucifer> <f33a9dca-03d6-45f8-bd25-717b9033c75c@gmail.com>
 <ak-2VAwNNuCD98Jv@lucifer>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <ak-2VAwNNuCD98Jv@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/26 23:00, Lorenzo Stoakes wrote:
> On Thu, Jul 09, 2026 at 04:25:27PM +0800, Wandun wrote:
>>
>>
>> On 7/7/26 21:55, Lorenzo Stoakes wrote:
>>> On Tue, Jul 07, 2026 at 02:44:50PM +0100, Lorenzo Stoakes wrote:
>>>> See above about deduplicating.
>>>>
>>>>> +			ttu |= TTU_RESPECT_MLOCK;
>>>>
>>>> Hmm. I don't love 'respect mlock'. I guess we only know about the reason
>>>> being compaction here.
>>>>
>>>> But I'm confused anyway. We have the folio, why aren't we just checking for
>>>> PG_mlocked() here instead of getting the rmap to see if it's mapped
>>>> anywhere with VMA_LOCKED_BIT?
>>>
>>> Also, since compaction_allow_unevictable() is a function that is accessible
>>> elsewhere, you could literally just have a TTU_MIGRATION here instead and have
>>> the rmap logic call compaction_allow_unevictable() instead rather than this.
>> Do you mean:
>> 1. change TTU_RESPECT_MLOCK to TTU_MIGRATION, that'is OK.
>> 2. move call compaction_allow_unevictable() to try_to_migrate_one? but as you suggested
>>    migrate_mlock_allowed function, it already called compaction_allow_unevictable()
>>    in order to determine whether TTU_MIGRATION needs to be added. Did I misunderstand
>>    something somewhere?
> 
> The next paragraph addresses this.
> 
>>
>>>
>>> And then you could adapt the function I suggested before not to take a reason
>>> parameter but rather a 'is_migration' one instead possibly and then pass (ttu &
>>> TTU_MIGRATION) in.
> 
> 
>>>
>>> BUT. I still question whether this is at all needed since you have the folio you
>>> can check for PG_mlocked...
>>
>> I described a race scenario at this link:
>> https://lore.kernel.org/lkml/c372e68f-2bfc-45b6-a431-01bf55717247@gmail.com/
> 
> OK thanks. You really have to spell this out in the code in a comment, this is
> really non-obvious.

I will address these in the next version.

Thanks,
Wandun

> 
> I will try to look at your reply in due course (am between jobs atm).
> 
>>
>>
>>>
>>> Cheers, Lorenzo
>>
> 
> Thanks, Lorenzo

