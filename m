Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83558219E0
	for <linux-rt-devel@lists.linux.dev>; Sat, 13 Sep 2025 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723619; cv=none; b=AlxTJNUe0Y9zNwbulqRVwwD4zwxsz68K7hTx1cMNbeI95sd/DxfMORAul/LHM2j5tK3vJzD1GCS9HzVlAQh1NL+YvI63QeMO6WEgvdzEX+rEHDlUZePPkr0665hcdrD+irmozbCncmoUPVFDsVLUCuBjjxPnlG3IYoHR7AtsR0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723619; c=relaxed/simple;
	bh=6ixjMQGo+mF9rxxhZunX9VzR5bs0JXrtOuI72NkTM98=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pK1cJ/5JfVQRg6pbM4YgfdSB2/rtDgBcZUARPx3JUQvcVQWYy2RVHeRURf/ENkckfH3KTjp/Kn/4cqaeGkRSvfSQ20bWw2LfjZcDGsjQdqlujIktjT4uBuUXSSDl89t5gtCoWnIEwP43xAC/FknPm8ez0QDHr2G8B5qQnfcYZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EX2o/wIe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EX2o/wIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757723616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncBfGy8EE17qYCVshxa8cc5ygoQQollWUOgPghVnN+8=;
	b=EX2o/wIeA6yu+Srg3Sxs2Y8vBkgsMaktHFj5GL3p7M1mFpdOiBZpNaSq1GHJqpr5Ku8IFz
	lAykwWGVWFypGy+7l551HJ7+pyYsrdoHcuyxDYZcMY0fB0/XeWe5V8A0sHe6tyX/kROj8d
	nEPzfWQqiGv/dpeyzGGCpxH9ALjz82c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-9lE3cq40M-K6dLDsV_uVEw-1; Fri, 12 Sep 2025 20:33:34 -0400
X-MC-Unique: 9lE3cq40M-K6dLDsV_uVEw-1
X-Mimecast-MFC-AGG-ID: 9lE3cq40M-K6dLDsV_uVEw_1757723614
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5f75c17a3so62884981cf.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 12 Sep 2025 17:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757723614; x=1758328414;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncBfGy8EE17qYCVshxa8cc5ygoQQollWUOgPghVnN+8=;
        b=YwAOBUqpRueup0ronCGW11jwTjju3RXxhWhwTcPVo/E5rBVdswazbscDBbBlRY++ma
         1Wc6mnhqFcC0lk+USBZ1HMkfa8HkCmgWCs7zoSskNdDvtnRVx72UA3EfTquEXk9i7k0/
         DCHehKMBS8pp2myfhZ9KCoNmTx+AfNc2kiN4UxZ0PaX2FDk4UKR9nms30QwMJB8j4ARX
         ozye8EL3XeSomV1v+oAaJLnj7BIZIcDzWNDjTySSkOQuXFSCKnx0Nf+ok2MYQmnq8L9p
         jkxJkhtRVRDDqTxC56lyAvBRlIxvtIaiJ407EaRIP5V06oppp0+UgqLjX0qIoL8uuHWo
         Zhqg==
X-Forwarded-Encrypted: i=1; AJvYcCW9ubh/VxATM7520pCi7VSaW4OEk4Gx57FQg62a6OcJKUgULmtxNad6TOggEXual22UxB13o/5T9tUkBYQ6pw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx15wuyHQTdwSUEtgoHoT6UNUzG9tU7vdP8GdjZRDQWZJeaMGuW
	/9mojWPrJWt5ubRWEfh5YivPvTJ202n3IMwqG8ITH8uLboUxFK8pEE9OJctjfr6edlbTVA3JDLV
	C7jDHbj4D9m3Ovohswnvv576VXOuGVdX5Xww6VkzRnv5iCMWkw12gTZD+e9uCsjCUejKc
X-Gm-Gg: ASbGncu5gR/6/+Nwqx3B47VZ/7tm9MWiFvYQr+ruQ52bqORfCp+CxZuCShvEaJ+XOHD
	YNH5y6Pkns4d7XvNmuDJvMJMQERHblmK07+c1e8XooCYDREP1yy5hj+4hAe+TlORANPIb9ppX9k
	h6x8e8UkOpL6TY+/d5P6+7zu7SR/kwTeTNqrDNB7CM7ymXg+C1/GbYR22WQfLW6MW1GO1TFaSNm
	emB26Jm9t8+A6izr1Yi7dlOgDSahLpwNuHiSLB8Q8LwUH+xfbV6kQnwgkt1/VQ+KJLZojc3W6EA
	MsTslvuuLxsoieKQ9I4RE6yVUujQCz6JcVIQ28JcFH6Mlpu6WZlImDrHQyECtx95ZULutcrNWyi
	RaotWgpVAzA==
X-Received: by 2002:a05:622a:1a05:b0:4b6:2f52:5342 with SMTP id d75a77b69052e-4b77d1ab3a1mr68076401cf.79.1757723614314;
        Fri, 12 Sep 2025 17:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRq8wbBNQnbSCZtG/tvewoa9dvMcBJkb7MXthP0yviRVZ6G/ctSPGgxUCMnelFEMNwo4BLAw==
X-Received: by 2002:a05:622a:1a05:b0:4b6:2f52:5342 with SMTP id d75a77b69052e-4b77d1ab3a1mr68076091cf.79.1757723613947;
        Fri, 12 Sep 2025 17:33:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639b99de1sm31462791cf.8.2025.09.12.17.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:33:33 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9d06c0d5-e20c-4069-adca-68a2c4cf6f4f@redhat.com>
Date: Fri, 12 Sep 2025 20:33:31 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-aio@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org,
 cgroups@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
 <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
 <20250912213531.7-YeRBeD@linutronix.de>
In-Reply-To: <20250912213531.7-YeRBeD@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ds35mrKyQhShH7xVbMtZXnzLHKZUUhvxMl8hvhlgacA_1757723614
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 5:35 PM, Sebastian Andrzej Siewior wrote:
> On 2025-09-12 17:13:09 [-0400], Waiman Long wrote:
>> On 9/12/25 2:50 AM, pengdonglin wrote:
>>> From: pengdonglin <pengdonglin@xiaomi.com>
>>>
>>> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
>>> disable preemption, which provides RCU read-side protection. When
>>> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
>>> manage RCU read-side critical sections.
>> I have some doubt about your claim that disabling preemption provides RCU
>> read-side protection. It is true for some flavors but probably not all. I do
>> know that disabling interrupt will provide RCU read-side protection. So for
>> spin_lock_irq*() calls, that is valid. I am not sure about spin_lock_bh(),
>> maybe it applies there too. we need some RCU people to confirm.
> The claim is valid since Paul merged the three flavours we had. Before
> that preempt_disable() (and disabling irqs) would match
> rcu_read_lock_sched(). rcu_read_lock() and rcu_read_lock_bh() were
> different in terms of grace period and clean up.
> So _now_ we could remove it if it makes things easier.

Thanks for the clarification.

In this case, I think the patch description should mention the commit 
that unify the 3 RCU flavors to make sure that this patch won't be 
accidentally backport'ed to an older kernel without the necessary 
prerequisite commit(s).

Cheers,
Longman

