Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C13BBFC0
	for <linux-rt-devel@lists.linux.dev>; Fri, 26 Jun 2026 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466810; cv=none; b=lUJxcx3QkPQ60bESueohsr1rfegKrhhALccdjl1/M/y/5xEZtqXsnirDo6O5t6gqIwaZtC2i4qm6VjjKKdTRwMREqIk4YRGqna5qN8uAQSa6mq2TUx9AVCXLJjXXKtpVJKytMkR6vOqlAHPQ6JiADLiIeKiB89LZ1w92jqZhb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466810; c=relaxed/simple;
	bh=l8xL8498nkpGzsqF3RDcPwj+lcf8tTvE9QMw1OS/d9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auan/NcGvobjCJ/9tOyboz0gutIzs4+B5xPAGpqO/vVadZDfJYADxI2qXRBIq63n9sBfCGeGjgvxGayZ5VY+gca/6Ly/INr4NL/9xl+bd0mxdShN14IhycFthpd1tSOwSTioZJh6ORO1IyC4zuiT5N3wsljrpYaGC3vADduKQBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHmBwiZw; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHmBwiZw"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2c6b3f71648so7652025ad.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 26 Jun 2026 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782466809; x=1783071609; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OU7EDEnprCD/MPTnLuThgw4IEgCvhreE+q7skzKaR3c=;
        b=RHmBwiZwb7ttL5PuJ0aSYCbXmVDPW91aSHJs5jK4/30Ege3TU2x+XtflTKKGSaR+qb
         /CP8IjVmU0sy3VBUxYqpeZAE6yhBh0YjfXeDVTTNmOHTyVpCgj9QGd9DEuy5Xvy3QOiY
         iEybIRMIaneiZB95W7NEEk+7DZRlcLF6Opscteo8wMgTEOjK8vbbeKCzRGhoz/S1gG4N
         2XOMgnLpGUVthiECh4MO9EDJsc3VHCoIJL1QX9sUP0AA2ckWx+QEmK5XuiD6vX4g6ErF
         /SfW9/egydeXg+xeZhXz82uwW8Jq5iNamrJdTdsvTKP7LY11cYyHkukS4xZoWgbNZ8gE
         dAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466809; x=1783071609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OU7EDEnprCD/MPTnLuThgw4IEgCvhreE+q7skzKaR3c=;
        b=GVgi+7s4d60QqfSnCzoPZHOa0vtTx1luUjAUAXhFABJcdCuP0yLJBk7oeA0/OhXtMe
         UWCdOPCRnocUvXRGszrU4ur3T4cEOI+8HoSyEdyO0BN1kubt0nE7yg2kBff8pPnyP/SY
         uoo9M+AF9XgnGCEOYRqZp5FuRrGn+xoc6910vZolUSdCXEqBuT5AskGTqKBKZEpCseNC
         BPw4hAAQzs7jv9Kgr67zsZpN65eCE871t0js1G+yA8uYFSQ8UzW5+RDe16S45+hQExPe
         nAuxaF9xLGXYHPUL0xi1NipuGkve5iOg+jk18Q7CEYS0rcODpuUAERcdxvOJpD6M4n0T
         I5OA==
X-Forwarded-Encrypted: i=1; AHgh+RoFne2n4WcB5wID4rZDZhm1gtpqfP67qB1G6KsmSea4d49h6+uqwZL9BAMVcY9cgsWlTPnX2SJJn+xMZyV0pw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw78IN0o8HPW3vTRusWrAGa3JKhMqV51fWaQbL2CiapMTGbtoFn
	wFRMkndB1iIBPlb5ZJzVMh7QqhunakQnt5duabIekclwn+uOmKPfRZXF
X-Gm-Gg: AfdE7cnabwaljVzk/eHeDgCNnP9ye4PcAVPVUcDPfwlKEF3sEwHUoDgAVv/A8ttw+Id
	lu6jzpF4edFpzykX4Jy8W/1sKwgKv1KfMfGU5VG7hxopkB44KrUtoL1oZtpjguHSFXbiqIRHpp8
	8Xk29WpjOfHoBhZGe8mDvGfpHbWwwNZRv4WtO+xHkWtvtqAHpyL4/mwsnAAZtxEMzFAbrvQs9WU
	9lqUV/+asEcs5HMt1U9PC0KYD9u4Hh0aZDW70Qk4BQv4wa4EUVZZOf9CqsB5OkNyNv9rnxflCn2
	GrpJOdyyj97WWV/hvn1VUTS9B60owQ5WXMuqvulRkIh7Zl4lLGA24FLiE42RcnkBkHqUATNW9QP
	QXnixJD2ddNy37JYjSyAMZwpgUwTONU5bV1sdc1VYWYvuEpD9ND+aDS/IIAmMcpmwv8/zQOE9OG
	tIrbvos+D8kXEfsr/4GeBHyNdmXnlafVM=
X-Received: by 2002:a17:902:e744:b0:2c0:b35d:ed54 with SMTP id d9443c01a7336-2c7fcce0738mr61668045ad.35.1782466808869;
        Fri, 26 Jun 2026 02:40:08 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afcb18sm36565685ad.31.2026.06.26.02.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 02:40:08 -0700 (PDT)
Message-ID: <47b53ee1-1077-4689-8be2-433c6db6fa81@gmail.com>
Date: Fri, 26 Jun 2026 17:39:59 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 akpm@linux-foundation.org, vbabka@kernel.org, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, rppt@kernel.org,
 clrkwllms@kernel.org, Alexander.Krabler@kuka.com
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-2-chenwandun1@gmail.com>
 <20260626092606.7BgipTin@linutronix.de>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260626092606.7BgipTin@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/26/26 17:26, Sebastian Andrzej Siewior wrote:
> On 2026-06-04 10:38:10 [+0800], Wandun Chen wrote:
> …
>> Reported-by: Alexander Krabler <Alexander.Krabler@kuka.com>
>> Closes: https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> Link: https://lore.kernel.org/all/33275585-f2db-4779-89f0-3ae24b455a67@suse.cz/ [1]
> 
> Is it possible to get a Fixes tag on the final fix so that it can be
> backported stable?

Got it.

Best regards,
Wandun

> 
> Sebastian

