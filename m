Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC1B1ACECE
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Mar 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233137; cv=none; b=a5xtAjIGC9i1lEPhFSOhFDmi4Z5ZKlqFP1NzHu7sm5+EhYH0Iogq8l5XGV52Qu7EPTaCCHL1AgWInyDrVIIfYZDs59NLuWSr1vxwEV1FhApq9OcefwAiOXS6ctT4RCs3IHjKoZYkte9+4BtaQw8+PzunET+ynqgpJBhFOBQsWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233137; c=relaxed/simple;
	bh=s+9ZsvkD2j3GdUweFp66Lf7ZZK215lyFm/3uP/3NPVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kmQrWze4sa5SzMiot23RG5+rPIGdJBLWdZ+aN395zWyh0HaSjJXELVsxxh/vKLSNxgRnK7vVNjNASxsBgoY99AYB5GgRtXWi2x4QRzuuE90ojo6P9rSF9LAuQUzctRjdxdEiEWunv3KCZrf41P6L7Kgrqrl+h0DSqT+RMyVlYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKu0R0zJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKu0R0zJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742233133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxJEMSGeykA76gAbT4QG8RZ8xXKOHWsugBkWtHC9fEs=;
	b=hKu0R0zJVv2z2kj/189C5YDshM0lG1Hx7JPTXgb6VhRdgBfvyVOTXwMD55QizFoXc17HRn
	U5lcFApDpvQPS4kv9eosYivCPSpKEWVoyjpb4mAQo8Lpudop20sV0NTGAcIGEs2q//Z/de
	fw65aO473fGETue9HOEAQMuvKMj35jI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-4eGAGX84NKqBbM_x-vNxPw-1; Mon, 17 Mar 2025 13:38:52 -0400
X-MC-Unique: 4eGAGX84NKqBbM_x-vNxPw-1
X-Mimecast-MFC-AGG-ID: 4eGAGX84NKqBbM_x-vNxPw_1742233130
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so14847415e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 17 Mar 2025 10:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233130; x=1742837930;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxJEMSGeykA76gAbT4QG8RZ8xXKOHWsugBkWtHC9fEs=;
        b=sMQjP3PFRWccJjaeNn5c1JXfjrCsLREzMeYJVmd+AmcFTquEFq8cxjj6COmc0xOPCw
         rVhnapQp81gsCR35GWQoqw0f+K+fNVKa9af7wpz5jCMwgq1ZhYQbzr6egwzu5YFl0/wO
         T6D2+q0QzfCC8oveMHFn5S+7n/zwv0QOJL0UkM0qR64W7mR4+RwH64zAbki1ZEPDMaJz
         qjl32LjbOC1KGyZfoOlc/MO9p2iW/Dy7JARkye5/5Rndug1ATyb9kEnGXcYRAbmZssU7
         SL2m1zC1Xb16lpTB9OsRngeuftxaUDED5I+9/MhVmnS3ZrmFPMMR3DFB5H74XXFXrTBY
         ZUWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUESbasf5Bbn4fp6t+wUuRQ6Cw79YYZSJ+ky7hrUux+fbE/pWSbOPpAL0hvTGjWi8eHqWm+oEpmEKZieR+cdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbJ615X8M21R+Mg3t189vFyhAzWsqhVOKqz6boCF1llBvvTebX
	ffmA1m1ryp1ZUQZAEaQKKC6AkHeKrenPZpsdwe/qnuLlX3Xz3toDRjtGMJn9RLpb/eCU377blmd
	rX2J90Bi148wrWFargCmDVNh34VZ4pu2OvxNXQbssTa6qOTHK60V80fn+FN8A7v94
X-Gm-Gg: ASbGncsFn6AFZRBKe+kVmoczcsZtQujamAZU6LPZ3BAWHOepOYehdl10nacQnSY5Zqm
	2Bb4surzx9HPDL+TZmp5EjvJURG51wgQNjcgF3+TFKeHgw8ILDUUlKMtsN9lZfjS2KKT+sMWGa/
	G5wgJzceONNrP1s6KPRVHKzpeOzlBbH1YpoADx9GowqveMg8itfd6E37LZL5F7AK9HwN+MzSuf+
	GahbTkYD7BiGY88lbGrky5/TfKvKq2W5n2yetqUeG/6lblDuZDqPW2m3IeYz/tJqqHMiYFome09
	vn1xn3j+M9tEoJKPjZdmmPFPRpRGjR9RiUILVNuG9fPtpQ==
X-Received: by 2002:a05:600c:1392:b0:43c:fe9f:ab90 with SMTP id 5b1f17b1804b1-43d2565453fmr83010515e9.28.1742233129622;
        Mon, 17 Mar 2025 10:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH79Njna9ru06osa+6QDxJxQgmXhABSjMREkRCTNMy/jkQd2pnE4lCUFaOogWeF/asOX2iycg==
X-Received: by 2002:a05:600c:1392:b0:43c:fe9f:ab90 with SMTP id 5b1f17b1804b1-43d2565453fmr83010255e9.28.1742233129187;
        Mon, 17 Mar 2025 10:38:49 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe152ffsm110082015e9.13.2025.03.17.10.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 10:38:48 -0700 (PDT)
Message-ID: <64d435b2-ef49-4be3-aa73-a065d7b9fbbf@redhat.com>
Date: Mon, 17 Mar 2025 18:38:47 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/18] openvswitch: Merge three per-CPU
 structures into one.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Pravin B Shelar <pshelar@ovn.org>, dev@openvswitch.org
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-11-bigeasy@linutronix.de>
 <0c5a60bd-ceaa-42f1-8088-b1e38f36157b@redhat.com>
In-Reply-To: <0c5a60bd-ceaa-42f1-8088-b1e38f36157b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 29wyBNtBTWN6rTYPDhjhFKVnVnlfwapc5xEyUieNmQg_1742233130
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/17/25 6:34 PM, Paolo Abeni wrote:
> On 3/9/25 3:46 PM, Sebastian Andrzej Siewior wrote:
>> exec_actions_level is a per-CPU integer allocated at compile time.
>> action_fifos and flow_keys are per-CPU pointer and have their data
>> allocated at module init time.
>> There is no gain in splitting it, once the module is allocated, the
>> structures are allocated.
>>
>> Merge the three per-CPU variables into ovs_action, adapt callers.
>>
>> Cc: Pravin B Shelar <pshelar@ovn.org>
>> Cc: dev@openvswitch.org
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>>  net/openvswitch/actions.c  | 49 +++++++++++++-------------------------
>>  net/openvswitch/datapath.c |  9 +------
>>  net/openvswitch/datapath.h |  3 ---
>>  3 files changed, 17 insertions(+), 44 deletions(-)
>>
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index 704c858cf2093..322ca7b30c3bc 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
>> @@ -78,17 +78,22 @@ struct action_flow_keys {
>>  	struct sw_flow_key key[OVS_DEFERRED_ACTION_THRESHOLD];
>>  };
>>  
>> -static struct action_fifo __percpu *action_fifos;
>> -static struct action_flow_keys __percpu *flow_keys;
>> -static DEFINE_PER_CPU(int, exec_actions_level);
>> +struct ovs_action {
>> +	struct action_fifo action_fifos;
>> +	struct action_flow_keys flow_keys;
>> +	int exec_level;
>> +};
> 
> I have the feeling this is not a very good name, as 'OVS action' has a
> quite specific meaning, not really matched here.
> 
> Also more OVS people, as Pravin is not really active anymore.

FTR, I'm processing the PW backlog in sequence (and with latency...),
and I see only now this point has been discussed in the next patch.
Sorry for the noise.

/P

