Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4F2BDC37
	for <linux-rt-devel@lists.linux.dev>; Tue,  8 Jul 2025 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963319; cv=none; b=kbLpwnVVOWbjw3nvElRxodAjOJ9OnyD5X9/vtVbXviy46WckijBSu9RRHvC/RNxOc35e9pvcscZCPNLaBK9GNOciSDbGOHgtmBMHEbynY6fCc+Mm1FB9HW0/CdCXoSpNQRUpwbQVvsL4kuWnEgAJvAR+jACLwPxC57MJVSRc4IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963319; c=relaxed/simple;
	bh=aTVqbBJCrpdA/23ncYm6csiwV9ujBFQ/Zovn7BQNI0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ED4Raaijo9xQuLqUFOt+Xu5lajaNlupT2rJlQI3CDz6/czbMRTDUQkDPyvU6uUgCTedKthf+ZfEZixFYFd1mLYQV2X1aSLluNx5hL3/O7qtBkLyJHjqaMjv/twF7wHJPaEvYuZGlL59tgjMzaQHobMD9cOa2aHs5gwIaBSUpmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZazrS/8y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZazrS/8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751963317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxPFV3tFLky59XA4g/lfynYxXJjgy/YJX1OKkvxJ+rI=;
	b=ZazrS/8yVS0fMdBs6U6IcugXlN1NsWwxIw4Iyy3uw2be1qb993pqMOvH/POnIHW85HjEBE
	GRe4cQYLz2SL4Q5njBfJ5eGPsaivFD5/ay/W+pu5Z3q1+cg3DwU4hn2daUQIZhRWs8StN6
	lFADHdelW0NL8hacydFBiMXeOIWbkdU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-s6iDsI2rOJqcKpFhxBIFrA-1; Tue, 08 Jul 2025 04:28:34 -0400
X-MC-Unique: s6iDsI2rOJqcKpFhxBIFrA-1
X-Mimecast-MFC-AGG-ID: s6iDsI2rOJqcKpFhxBIFrA_1751963313
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450df53d461so31635095e9.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 08 Jul 2025 01:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751963313; x=1752568113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxPFV3tFLky59XA4g/lfynYxXJjgy/YJX1OKkvxJ+rI=;
        b=Ms5UZW7jCE+1RbPN43DYH/HzWCLhBSVWQ0KRfHFisxJEoipZVRXtKDEUz/KoKETTBt
         06iAsgn6TzWENcvmov/6/CCrb5dLrFyy4WHagakN7Cu02NJAsUzoy2jtlAVkXUDA6fdl
         EsmV/CoUk8GCLGOf5QyOKFWsbfl8Y3wDBmwFDCiPoq+NsSV44U2OJpimhBC7Tmd4G7hg
         FsV652H/ufUfL330KdGGRtPkVpWZb5xS/0Sdl1a0du85fjJIFMGAjdYX/AqFwr5Eey3i
         LClA6aQhB37IiUNa7XJ0piPeJajHssf4Lunl3tYJ1Vpskb42DqQmLbAWHM5sHJL1iVm7
         W2jA==
X-Forwarded-Encrypted: i=1; AJvYcCX903Pv0VCpTtdVZbm0D+3xaTlQ6cZJn0/VXo/NzP3cXUh35lLNY5+abqlyYvUsw6ycUcxEmjr3CLeJJAw3dQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBfSJRFcw914X377nOphiJPRtmvkkrzjH1LKhVEkcD2FlM3Pmo
	SuGxSX9eFw52VKNOq9g5FirlYqrOVQwvaf2QLWjujEl683+J2I+eXlKm2GFYRcIUnBDVg14wUYx
	8V+YFGxSeJJrnY2knIITQ7yhDxyoqlrHHmQ3/Q8rKHdTt/RkY7Z0KMwPQBR7lecPOZeMx
X-Gm-Gg: ASbGnct1/CPbcMNzl74ExSz1wNv77k8pjc7CrHjUirPDdw5IRZpwiu5AEZQX4KeVb3E
	+OcFiEby79H/jk2pa5Ue0WugxZ7Cgj9Jy500Mrc4m6O+HQwcX6dl5ifJf0sNdPRJGOSF0zCyOTl
	PkhOJ7VF6fCwp9RD0PcVMCCu6a51ZczRLJl/FiE4GmD1PjFx5ipW+8Lf+4cXu76ZB/drHaN8exM
	znT2fgmQf2QV2uaMJ0sGsZlBSaKdkVaTOrpmL7781W4/ktHGg9B5vLew6X8+Eq6O3VbzazOwH0g
	T5/0oVdm4MrKM8CsiBYiMOtEVT3/JS2rsWliMjIDOZqpAz19SOf95fWCc1AmKe2Ac9KQcw==
X-Received: by 2002:a05:600c:a087:b0:454:ab1a:8c39 with SMTP id 5b1f17b1804b1-454b310d890mr135455765e9.26.1751963312710;
        Tue, 08 Jul 2025 01:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKeZmp4gshJPfdVZLft+U6QKBU434mwlK26v/9HLXxDoFpa/+j0LPJFeFl/k2mvKbg4sYKig==
X-Received: by 2002:a05:600c:a087:b0:454:ab1a:8c39 with SMTP id 5b1f17b1804b1-454b310d890mr135455575e9.26.1751963312271;
        Tue, 08 Jul 2025 01:28:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c90esm12502048f8f.91.2025.07.08.01.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 01:28:31 -0700 (PDT)
Message-ID: <1eb149e6-68e7-4932-8090-34ee568c5832@redhat.com>
Date: Tue, 8 Jul 2025 10:28:24 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ppp: Replace per-CPU recursion counter with
 lock-owner field
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Clark Williams <clrkwllms@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Gao Feng <gfree.wind@vip.163.com>, Guillaume Nault <g.nault@alphalink.fr>
References: <20250627105013.Qtv54bEk@linutronix.de>
 <9bffa021-2f33-4246-a8d4-cce0affe9efe@redhat.com>
 <20250704154806.twigjkbU@linutronix.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704154806.twigjkbU@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VSpMhWogfBedzO4LTUwXGkxQECOc-FSV1FSterEaFxE_1751963313
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'm sorry for the latency, OoO here in between.

On 7/4/25 5:48 PM, Sebastian Andrzej Siewior wrote:
> On 2025-07-03 09:55:21 [+0200], Paolo Abeni wrote:
>> Is there any special reason to not use local_lock here? I find this
>> patch quite hard to read and follow, as opposed to the local_lock usage
>> pattern. Also the fact that the code change does not affect RT enabled
>> build only is IMHO a negative thing.
> 
> Adding a local_lock_t to "protect" the counter isn't that simple. I
> still have to check for the owner of the lock before the lock is
> acquired to avoid recursion on that local_lock_t. I need to acquire the
> lock before checking the counter because another task might have
> incremented the counter (so acquiring the lock would not deadlock). This
> is similar to the recursion detection in openvswitch. That means I would
> need to add the local_lock_t and an owner field next to the recursion
> counter.

IMHO using a similar approach to something already implemented is a
plus, and the OVS code did not look that scaring. Also it had the IMHO
significant advantage of keeping the changes constrained to the RT build.

> I've been looking at the counter and how it is used and it did not look
> right. The recursion, it should detect, was described in commit
> 55454a565836e ("ppp: avoid dealock on recursive xmit"). There are two
> locks that can be acquired due to recursion and that one counter is
> supposed to catch both cases based on current code flow.
> 
> It is also not obvious why ppp_channel_push() makes the difference
> depending on pch->ppp while ->start_xmit callback is invoked based on
> pch->chan.
> It looked more natural to avoid the per-CPU usage and detect the
> recursion based on the lock that might be acquired recursively. I hope
> this makes it easier to understand what is going on here.

Actually I'm a bit lost. According to 55454a565836e a single recursion
check in ppp_xmit_process() should be enough, and I think that keeping
the complexity constraint there be better.

> While looking through the code I wasn't sure if
> ppp_channel_bridge_input() requires the same kind of check for recursion
> but adding it based on the lock, that is about to be acquired, would be
> easier.

(still lost in PPP, but) The xmit -> input path transition should have
already break the recursion (via the backlog). Recursion check in tx
should be sufficient.

All in all I think it would be safer the local lock based approach.

Thanks,

Paolo

