Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B891A0BF1
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Mar 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232599; cv=none; b=HJ2i33AG72wZQ4cX2/9Sw6joF06YOmaEnge5CzHIQwmni9ztqbMMtWYcGGGK5u4stl4H+ItOTajb/ps0v2zW1R2ckdhmkQPL4Z8j8Ko3a44f+zscUS/3FaXSajPppQrIR+gYyNQbZAEufh79PIi56gFCBleDkmvI9kaV1Vyxo3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232599; c=relaxed/simple;
	bh=HR5k8BiL7B2OPxerAEdBBqmo9n0+6ON8MsRWRTCDshU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTE8l4Mvnx9ZQVr+2mEOlcaeiqy5jXo0MyZLQPP52jDjnXJl/268B/3XIQ1V+LDvOcBv3yyREem3vti3UzYyvr5HhObhiJZmmtU/lH5JCWrh4r7oDYSwubpQX8rSKUqPSOHbYn2ZOehzBzAAcFkUzprknYCEKAm9AsA5Z2gB1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yif+GOWk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yif+GOWk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742232596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLiAoQcg8KzfhuMFjYbt4oXsOhzaJWAzjx8x5W0S0QU=;
	b=Yif+GOWkahVVwF/n0W4tjoaOpoSBaxtwqwvh1OM/DLv4o2aI6PlhrFLr2KXsIwfTyd0rzL
	h4vQ5s8MIOC+o3wh3bflt4tcTnZiX8Y8mPwEn9L1yoWxAKv2wiwt4RX75vXG+3U9thacfE
	4pkZ5FrHrh9qKrLLw8E7h4H/V9aywmk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-uNglsKh_OAKeOR5jKRUyMA-1; Mon, 17 Mar 2025 13:29:55 -0400
X-MC-Unique: uNglsKh_OAKeOR5jKRUyMA-1
X-Mimecast-MFC-AGG-ID: uNglsKh_OAKeOR5jKRUyMA_1742232594
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912aab7a36so1989769f8f.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 17 Mar 2025 10:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742232594; x=1742837394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLiAoQcg8KzfhuMFjYbt4oXsOhzaJWAzjx8x5W0S0QU=;
        b=ltMofRnIumNuFPMhk0+QuKZQjmcs3DwkCG+QwZvD9+m67atDWV6DqWbZf7mRJh+O8T
         F2jHcaDZB959wgrETs0OHYuW91H2Pv+wh6/c6vTzAth0j24vNz6ofjM0kdiJVgZOYsAr
         ZnukAjiVEAW0KkOZDshoz2k4tMJrAUfl2IADFIilU/Je0pyTXF/NuoV94PmOjJUbEwgs
         0T762V3s5pPWbOTam5R3dPfTub0YegX6d3NdxWGjN+0plVtuiPyYlbJV3ikngGTiEHGm
         F3CysgPgx7HsiKOsRIA7yst6ZlIZLkXNwl97cYmy6d5nlVeSEIZARuq2McaDVQT2wqpJ
         H0yg==
X-Forwarded-Encrypted: i=1; AJvYcCVJoi5YzFyfeCoxFLOcbj9RqyKJjHUGubWDMun3JhMxLNuhY87PXuM0dg+BU9W79UKnyoenTXvzs87g7iVwkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxeKz9iokdiu4SzxVTmaXsNirRSCxSnBfhB/O/0NpWqElWjvrI
	vtgi4TeiuUfLYHng8fZepRrCQGE4QtfRLMjVdP6Yws0G9Fsn97a8tJ3nrjIeiRcY7SGqJw+i46e
	8QFo4KmYiffqo6J3CsqlUCvMjFRX702yZ0qZKRrFr0ijGyd7R8/pAUTaGm2I33zjh
X-Gm-Gg: ASbGncvyicTHLKVptDZLG74JMtinuA2cI4FUopR3WFRYW4mnB+XUcnSChLhCgMZR/1l
	/Yyy99WerE4cLTlYYGtIidkU2qnrkUJLUzBhqatRaz47Hj3Bulrt1YWs+FAggdsnryR9rqz1Jra
	L5JqdAbIWc1ttm4BYi3Vrf+hwzHybqnxqtEo97mdxmsGJIcGhvYfJ/GPGYUoCas3dic63hkbl1t
	ODYyF/4wC06P8YJamKaNDkjDeVnqUl0dCIFekqM9T3Hc/c5kPfnAx2T5/AjhsnwEjPyAMBKniWx
	zY88YU0yVEsiU7jYRHwK/XeN9AcqYOien27eeOeWLaRkbg==
X-Received: by 2002:a5d:5f93:0:b0:38f:355b:13e9 with SMTP id ffacd0b85a97d-3971d42ae27mr16648615f8f.15.1742232594182;
        Mon, 17 Mar 2025 10:29:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkszNmgMJv2EU7OnN6gBdg2W+Pp+zusqYC+Tkof3RN2Cf33xU23BRZDTBqd0JusGhCLQWrCQ==
X-Received: by 2002:a5d:5f93:0:b0:38f:355b:13e9 with SMTP id ffacd0b85a97d-3971d42ae27mr16648574f8f.15.1742232593799;
        Mon, 17 Mar 2025 10:29:53 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318acfsm15911566f8f.70.2025.03.17.10.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 10:29:53 -0700 (PDT)
Message-ID: <99214ac9-cff7-4a5c-b439-ed9ec2c6877c@redhat.com>
Date: Mon, 17 Mar 2025 18:29:51 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/18] netfilter: nf_dup{4, 6}: Move duplication
 check to task_struct.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-7-bigeasy@linutronix.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250309144653.825351-7-bigeasy@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gNfMeDB3E65IxlWtFkRyEHQ5xi7oHB1YKPOzgKsdxsQ_1742232594
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/9/25 3:46 PM, Sebastian Andrzej Siewior wrote:
> nf_skb_duplicated is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
> 
> Due to the recursion involved, the simplest change is to make it a
> per-task variable.
> 
> Move the per-CPU variable nf_skb_duplicated to task_struct and name it
> in_nf_duplicate. Add it to the existing bitfield so it doesn't use
> additional memory.
> 
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I'm not a super-fan of adding more flags to 'struct task', but in this
specific case I agree is the better option, as otherwise we should
acquire the local lock for a relatively large scope - the whole packet
processing by nft, right?

Still this needs some explicit ack from the relevant maintainers.
@Peter, @Juri, @Valentin: could you please have a look?

Thanks!

Paolo

