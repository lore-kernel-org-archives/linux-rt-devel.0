Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D734A3AC
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Dec 2025 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991974; cv=none; b=RWGtpF9AdIy5Tc5o7RU8gdKXQWwIYBS6jOStiuSUgQmTmvNX4rCCUk897J6FEgwfcQSJv/z7xDcuoJn11TfSUyzBtv/Vb7DwjrXTkS0hdnrKS6sxTd8YBVGc2JevDWKh2zRh0zIpqZcgOX8I/t5ru+vBAP6OaGxzp8ER9zekG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991974; c=relaxed/simple;
	bh=nxfMjWlGH75gU72zw0mAEOa0tjE5Lk2Vo0HgdWgx5UY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l9CLOzG9CjHI0y/OoHM/7PJzOn7g961L3dqsCk0vn0MjNHmgmPgeZPmW00rWbMCaGA0rj1w8lz7nShwKooGdkhhn/bA9f7Jqi36FmrnS0aHWwKsrY5lapNVgUrzFydd7uxT96YggJkWx6qyTOf84J0eOiPNHjVIgLStZOdAxYBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rtw3u4G1; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rtw3u4G1"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43102ac1da8so2054385f8f.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 17 Dec 2025 09:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765991968; x=1766596768; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fmH64XmJ0F0IHGr/hDAMtzC5HIceqcOPcSCpGBeY+GU=;
        b=Rtw3u4G1NIfpqwwVewyM6fSicpYmtTR/sjTtXgyT/8fDRMuJAZ8hYwhk2BaxqNH5CS
         9QkINHvMNrPLCJ0j23kqBOih0/eP7qK2rZefGdQjvGaFSTJhQ3z0Ln2BMuZkHus9yash
         uf92g/YB1hAOgLLzFK3D/rKlwkWn3g7iXxu0t/NgOtP1d3lWQvRhJ5yT1/nKdQ7TaUwh
         JNc11GF8LnhXpuXgb0T9LF9e1BbybKAnS+W4cNa+HThBnkQOxNlMK0YyKJytJ+pKzjBj
         fKDov8rhw1Gj8yydzOlO2eg8+N8i4hamMUt3T970z+YVl72RUgvS7pAgKufs9cINnU5A
         MUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765991968; x=1766596768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmH64XmJ0F0IHGr/hDAMtzC5HIceqcOPcSCpGBeY+GU=;
        b=dhiK3m+gt+dcPy/mqt8u4g2SXBBAh1KZ+CP7EG8zoQdf9V6fSuK1hZ9afkTln22Rdd
         +S7bqyet7zZBZSZU9D65emKJQ98DnzUon7xs0x2NtvD5AniAplnp7g56/J+K6SPFlQVW
         RPocaE4I7gfTRde+ovECHqfHtNrJ+JvHvBgo9LMtk+i/2rq2dsUApbhTFztMd0Z3Vvw2
         hy4vnLth/WAeYkrEI6sbXEUCUxEhPhZ/TQubCamSyvhhpYG7TqQhSDXYFfv1jz1l/2SI
         YC7G7s097itYcKJcpqL6YBf6sESPcWQdMldFZFSWQ64Ih2Lun3VzOohZfJxYvEf8YShL
         YIvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJLjtPjb9FBy51xB/rGgdXdYEoRgzL4abEJGczJC5O2cpQxM+lYuka5oCkCnlkVhsFaTR4Z5QVsWFpJBzXIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMoqSjZs+EGrKLYQ/IqxMQYmSRK4INcZ8DMDqrsf05R04CIzrm
	X6jjFPqDSFzQTL+6LFnCFM21h7S3kaSWIKd+ik9h7BcX1XlDQgkt2nZp1x/NAncb37VhQVjUqwn
	dJfPUARb/vHlrJg==
X-Google-Smtp-Source: AGHT+IHT10heBTKc0la75zjUcdcWeKQLxIjteE6wN3WG7RYWYRpvl3lG55/6zSe2LENPLJF5rOBhHUOFskHNYw==
X-Received: from wrbfo17.prod.google.com ([2002:a05:6000:2911:b0:430:fdbe:cc61])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2404:b0:431:864:d492 with SMTP id ffacd0b85a97d-4310864d73emr6566925f8f.36.1765991967910;
 Wed, 17 Dec 2025 09:19:27 -0800 (PST)
Date: Wed, 17 Dec 2025 17:19:27 +0000
In-Reply-To: <d5354d96-6f28-41d7-9f66-64c254d9477b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251212161832.2067134-1-yeoreum.yun@arm.com> <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
 <aUGOPd7gNRf1xHEc@e129823.arm.com> <100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com>
 <aUKKZR0u22KOPfd7@e129823.arm.com> <d96ac977-222e-4e8d-9487-da1306198419@arm.com>
 <aUKnfU/3FREY13g1@e129823.arm.com> <d912480a-5229-4efe-9336-b31acded30f5@suse.cz>
 <DF0J58HOVLL4.2E16Q87D2UXRW@google.com> <d5354d96-6f28-41d7-9f66-64c254d9477b@suse.cz>
X-Mailer: aerc 0.21.0
Message-ID: <DF0NWLWKRKYI.3PLY78UGGG2PD@google.com>
Subject: Re: [PATCH 0/2] introduce pagetable_alloc_nolock()
From: Brendan Jackman <jackmanb@google.com>
To: Vlastimil Babka <vbabka@suse.cz>, Brendan Jackman <jackmanb@google.com>, 
	Yeoreum Yun <yeoreum.yun@arm.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: <akpm@linux-foundation.org>, <david@kernel.org>, 
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <rppt@kernel.org>, 
	<surenb@google.com>, <mhocko@suse.com>, <ast@kernel.org>, 
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>, 
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>, 
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>, 
	<haoluo@google.com>, <jolsa@kernel.org>, <hannes@cmpxchg.org>, 
	<ziy@nvidia.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>, 
	<rostedt@goodmis.org>, <catalin.marinas@arm.com>, <will@kernel.org>, 
	<kevin.brodsky@arm.com>, <dev.jain@arm.com>, <yang@os.amperecomputing.com>, 
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, 
	<linux-rt-devel@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

>> From 4c6b4d4cb08aee9559d02a348b9ecf799142c96f Mon Sep 17 00:00:00 2001
>> From: Brendan Jackman <jackmanb@google.com>
>> Date: Wed, 17 Dec 2025 13:26:28 +0000
>> Subject: [PATCH] mm: clarify GFP_ATOMIC/GFP_NOWAIT doc-comment
>> 
>> The current description of contexts where it's invalid to make
>> GFP_ATOMIC and GFP_NOWAIT calls is rather vague.
>> 
>> Replace this with a direct description of the actual contexts of concern
>> and refer to the RT docs where this is explained more discursively.
>> 
>> While rejigging this prose, also move the documentation of GFP_NOWAIT to
>> the GFP_NOWAIT section.
>
> There doesn't seem to be any move?

This is referring to [0] and [1].

>> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
>> index 3de43b12209ee..07a378542caf2 100644
>> --- a/include/linux/gfp_types.h
>> +++ b/include/linux/gfp_types.h
>> @@ -309,8 +309,10 @@ enum {
>>   *
>>   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
>>   * watermark is applied to allow access to "atomic reserves".
>> - * The current implementation doesn't support NMI and few other strict
>> - * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
[0]                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^
>> + * The current implementation doesn't support NMI, nor contexts that disable
>> + * preemption under PREEMPT_RT. This includes raw_spin_lock() and plain
>> + * preempt_disable() - see Documentation/core-api/real-time/differences.rst for
>> + * more info.
>
> Can we reference the "Memory allocation" section directly?

Yeah good point. I will send this as a standalone [PATCH] mail tomorrow.

>>   *
>>   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
>>   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
>> @@ -321,6 +323,7 @@ enum {
>>   * %GFP_NOWAIT is for kernel allocations that should not stall for direct
>>   * reclaim, start physical IO or use any filesystem callback.  It is very
>>   * likely to fail to allocate memory, even for very small allocations.
>> + * The same restrictions on calling contexts apply as for %GFP_ATOMIC.
[1]     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

