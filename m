Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020A22B8A0
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Apr 2025 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876886; cv=none; b=OsGGTZ+NGTnP3Mzje0IwadrcIWZzaXuaCSrj4BqnKV53neqpiyaPf1gC5v9EAm0QeJz3aLDh7CpPkgMTE6Ul6Bz44gg5vq9dlY361mybBrTEVKOZ8ysoLh3T8jICcv3nycfFBj1ZcR1a0Sn5YUZHrwPzwXVbqu7T5SXLqG9V7Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876886; c=relaxed/simple;
	bh=mbIJn3m25HB/f+imm3wATVam8c+NosvFbYpGMY2/ufA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwIGIHhnV9kckas77V7TZyxFa5S1arP7wjcjq+BdaHzZfu96j6Aestxx40DlbxiAMZNriSDTlLyeLmwFP7qYfWfsht/kW2qy+Rs0JZd6h4lLIwnfZlz6eeiaRymUe95O2dwqGT1osbWUwa3fnApDUBJN7BvJa52ZatuL2NtJuTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ed+3FYkD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ed+3FYkD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744876882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftRBl7J66GuD2x2LGUC/bS7+8GxCtzSAHVhHuUVU4wQ=;
	b=Ed+3FYkDu8tEyCl0a0SCqkcoBygAD5vxBXhMlV5vlfQ6gzXzJDTrQJSNN+WdU4s4zjW1c6
	r/I97oie/kHzuJ4Obnsx5FuHV0H7k4vFv0cArTKz1ovUbt+CZSyagLj+sazcNbGsYXm1J0
	TDwD9y9oVSwLMXHE3P6Q5Bxf2vlHbXE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-4lJGtLhnO2m_LYJYVSFVNQ-1; Thu, 17 Apr 2025 04:01:21 -0400
X-MC-Unique: 4lJGtLhnO2m_LYJYVSFVNQ-1
X-Mimecast-MFC-AGG-ID: 4lJGtLhnO2m_LYJYVSFVNQ_1744876881
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6eada773c0eso15051226d6.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Apr 2025 01:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744876881; x=1745481681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftRBl7J66GuD2x2LGUC/bS7+8GxCtzSAHVhHuUVU4wQ=;
        b=MJDiSsQ8BNf3lbdoBj2L/iuM+3koRmzej8Ma2ZVKYIz61Im4MrPQrFfaYGr6kBc5gS
         HHbCStjQ8YiNeW5reve1EnkonVYYiOgw63g+xGpFVg4H7PXLLJaLIirGjul7PgNyyMNP
         TBcYz4vOBvgT5PzjOfg7bhFSiR9qHAEn44ua0R+dNoS1U/6u3EmQ/amiy7yJYJJP69gX
         vN7c6Z8KymM3VjzVJWKHL1TjbnGkbhI5NTeBKI2XXl65WnoskH+JpirCBlUZEhZF9QCz
         VZ+rW1fCZHLOokqVn/i5yLakjK1YzrBOaz2FWfmtd38zWqNYtGWcg2TycNZmIJp338Kd
         kwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGCAQ6MWJWuQ5c71n8OBtZUthO02sAtKrkH6yejzNcxURGrDMCOIk6xX09mwf/TfIpDp6Y6hqc6C81TVMvaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWReJl1v4fSqKGdSY/L8jTGl4cnEgbMaJ4xCTuUcjhzIGqPUZK
	7GlAJph5DvwkAUf5hln4D+M1vuXGXDs88gwntLmmjfs1WEobCXcSXuxPy1TIh1HLLMimHJQaZOg
	O1L0W/Sn1r3WZrUPfJr2PjJQTGWPa89GenI4bylKOxuG/9saOzG6vXljLr72ixiM3
X-Gm-Gg: ASbGnctAyAib7k8HN+vNX25+qUDOvXibZprxp9g47NrO9L0dKWnp+3mL3mNasnElL0w
	Pr2NzdFKkqq8siYWDn2f5wJ7/OocdXhs07R4knZAepdJJRJHue64Q7Z+9J+i8oDom8nEpLWHWU+
	sk7StcFgeDBqemcR0VKVwlhhMRyJWclMjdEobXMwrZhiEgIHodyxLqTfxwgPAJFY+3iS4Kbcndb
	2XragMHrEEHtnEHtKE7wAiwU6VP0HNLHmmESAGGBINqt2us60RsHk6mAqn09IfdcbZUTmdxFxrE
	hws4FDLvz2I0gR6BdmJ1vEtgZeftGYhqmSXnRSNMhQ==
X-Received: by 2002:a05:6214:238c:b0:6e8:ddf6:d137 with SMTP id 6a1803df08f44-6f2b2f391a5mr81152176d6.18.1744876881276;
        Thu, 17 Apr 2025 01:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZEExXhG3D7PDOy9wbg64kxSzVMk8qG5CEf5EbB1KnD81xALQUO7/A9SSzykTzKL1UIe90fg==
X-Received: by 2002:a05:6214:238c:b0:6e8:ddf6:d137 with SMTP id 6a1803df08f44-6f2b2f391a5mr81151906d6.18.1744876880888;
        Thu, 17 Apr 2025 01:01:20 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95f99bsm126450786d6.25.2025.04.17.01.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 01:01:20 -0700 (PDT)
Message-ID: <867bb4b6-df27-4948-ab51-9dcc11c04064@redhat.com>
Date: Thu, 17 Apr 2025 10:01:17 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 12/18] openvswitch: Move ovs_frag_data_storage
 into the struct ovs_pcpu_storage
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-13-bigeasy@linutronix.de> <f7tbjsxfl22.fsf@redhat.com>
 <20250416164509.FOo_r2m1@linutronix.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250416164509.FOo_r2m1@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6zjMdpiWGsVRp7Wi6GgDgVgeKIj5g7F5sM6I7IkcKDc_1744876881
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 6:45 PM, Sebastian Andrzej Siewior wrote:
> On 2025-04-15 12:26:13 [-0400], Aaron Conole wrote:
>> I'm going to reply here, but I need to bisect a bit more (though I
>> suspect the results below are due to 11/18).  When I tested with this
>> patch there were lots of "unexplained" latency spikes during processing
>> (note, I'm not doing PREEMPT_RT in my testing, but I guess it would
>> smooth the spikes out at the cost of max performance).
>>
>> With the series:
>> [SUM]   0.00-300.00 sec  3.28 TBytes  96.1 Gbits/sec  9417             sender
>> [SUM]   0.00-300.00 sec  3.28 TBytes  96.1 Gbits/sec                  receiver
>>
>> Without the series:
>> [SUM]   0.00-300.00 sec  3.26 TBytes  95.5 Gbits/sec  149             sender
>> [SUM]   0.00-300.00 sec  3.26 TBytes  95.5 Gbits/sec                  receiver
>>
>> And while the 'final' numbers might look acceptable, one thing I'll note
>> is I saw multiple stalls as:
>>
>> [  5]  57.00-58.00  sec   128 KBytes   903 Kbits/sec    0   4.02 MBytes
>>
>> But without the patch, I didn't see such stalls.  My testing:
>>
>> 1. Install openvswitch userspace and ipcalc
>> 2. start userspace.
>> 3. Setup two netns and connect them (I have a more complicated script to
>>    set up the flows, and I can send that to you)
>> 4. Use iperf3 to test (-P5 -t 300)
>>
>> As I wrote I suspect the locking in 11 is leading to these stalls, as
>> the data I'm sending shouldn't be hitting the frag path.
>>
>> Do these results seem expected to you?
> 
> You have slightly better throughput but way more retries. I wouldn't
> expect that. And then the stall.
> 
> Patch 10 & 12 move per-CPU variables around and makes them "static"
> rather than allocating them at module init time. I would not expect this
> to have a negative impact.
> Patch #11 assigns the current thread to a variable and clears it again.
> The remaining lockdep code disappears. The whole thing runs with BH
> disabled so no preemption.
> 
> I can't explain what you observe here. Unless it is a random glitch
> please send the script and I try to take a look.

I also think this series should not have any visible performance impact
on not RT OVS tests. @Aaron: could you please double check the results
(both the good on unpatched kernel and the bad with the series applied)
are reproducible and not due some glitches.

@Sebastian: I think the 'owner' assignment could be optimized out at
compile time for non RT build - will likely not matter for performances,
but I think it will be 'nicer', could you please update the patches to
do that?

Thanks!

Paolo

