Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8223301704
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Jan 2026 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238083; cv=none; b=aMlndnXijiY+mUlMjESP+TnbeZaDUi1uUDYyO12F+hqclf1odNp47ecgdK3yCMihJLqeQd4VadVT/YwZLuF+mr7K/mJwg272pGTHrnWnzAeiFVndKcjiCQZc4cA9l25BuBVqG2LEzsf5vhFOyEwUAfPJkJe+IiX/BHgSOD4xaIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238083; c=relaxed/simple;
	bh=p2RIxY5fGlPnWZZI5ZaSHBVwyZ9upWMBTdLTBFx8kA8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j4/o0uPbNMna9SX0qZnaOME3+TfD3z0kk1alYOhb5YfPdUnimiBUdHlpG7VYcjrF4EFzLujRabmaDdNM7X2/anHc45nSJmRdidYYVLzsEIU6DQ6tVpCMenF74n/y8mCwiUXHr4RlsWBw8oFCe9aht7Z28C/pkw0KXxK4IY2ttw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNIldvAT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNIldvAT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768238080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=niuwlukY4G5Spngj6ahATQFt383vhuD9uikDSg5CgGU=;
	b=QNIldvATYbSWnJde4YkTNg0iRKOE9IHEHE63PYEXB2TtDR5kpWZGsJjnGk7VqYN+YMx0IV
	oak2o1B29qBqntCBR+AMjfs+Lm/75NfWVwQqCRPfBBdhPV1ePgpysHpP4Czo9yi8OnpgZ2
	aCaQ3xBBqJC9tWd96RUF5gZ1pvRfT94=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-2s4lxKKXOFy0rlVB53ON1A-1; Mon, 12 Jan 2026 12:14:37 -0500
X-MC-Unique: 2s4lxKKXOFy0rlVB53ON1A-1
X-Mimecast-MFC-AGG-ID: 2s4lxKKXOFy0rlVB53ON1A_1768238077
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56361fd5879so3612230e0c.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 12 Jan 2026 09:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768238077; x=1768842877;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niuwlukY4G5Spngj6ahATQFt383vhuD9uikDSg5CgGU=;
        b=A5AuucCmxrsM/9zlYvudaL85UgBsik+fDkF+U7jyyBu+gWYSG2zED249az/xIOCmbb
         dpPqzfqP0NK23WwgVNEb7nRywLw5kcBoehA9y+IpVf/jzjXCcnRAvwLoCGyjOHbAAX3n
         DZEK3AJ9EXwu4EB4ipcl119tjwFYH8rzn95KZsk1FbPTWSvOHvnbIJQLvT3aqTnTiVhl
         gvtHcXYQiMzmpgGhNLqNw8Io3qcrNvaHGlTYi96CP2jqdIhx23ajMkCrQ8IAT3arrXKD
         BMstmdV36mLksc3M6Y+XRGkNGXh/7qckrxUbd2E5RdvsOzOPtd8CuTHgEmNGf4m1AiCI
         dPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB9JTABZAO95Ql/GRMGNuvgT+o40kNgICb8iZ2GTJVUS2gBOwsHoWM28N/KMtbig8KlQpzFY+6AEtKa5Qy3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEXtNCaZG/TlKFltZd9CyyzypzBL5IKwL4u/F5SjF6hx45TtPt
	yvgD0Bq6TeGFP7njAXVWoQFxeRH6rjfQYtNYZkO/Q5eFXW1iwEcAWGBpT617rDgKIgR79zeQR//
	O5HoacoP1gVr1A+iYX5KcCbn1yv0UB9eWIAga3IIsntKoW1ZfScRY9Sk1+Up4odiwjwKN
X-Gm-Gg: AY/fxX7/aXjz6enqRvOg9JGwnRc8XjxtlWdqhnTL+gBBqIZHCbXv5lwGIWq/muOmfUA
	fJOqjzSnu4d7r8evlyIFTeFZR+ReYVzycpa00PXH++Py3OMHPBHiT7WUjk+yFxGS8mO+1gVW5GN
	9JQBaJ7q5YdPYBL8mLn3AnlQFQiuQmx7DoEVEqCGXkKGVcT0shEuiOo3EjaOg4MMACU/akxTDtI
	5tW29QHqP5I0qgNuApCMmEm26lhamFnHIq7wVo5D49Cmyr6CmkO7aQebgCd2WYMjtkxJJirAoQ8
	X5K9NRHqKfuuwtbom6D3gqbeW84xhIUKG4YrWkcoWpxRBVtn5S//nMdJwsD3kFSyikdf8OasQos
	q9tCm2wd8PfAmdvTwTkCbGMTftxyhBIjwr40sVwoS4jCzySOITuEqVzNU
X-Received: by 2002:a05:6122:2887:b0:55b:305b:4e3e with SMTP id 71dfb90a1353d-56347ffb9edmr5814840e0c.20.1768238076676;
        Mon, 12 Jan 2026 09:14:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlqbRNk7nmg9s0QyR3wuxXiH+S603lyrhRY4LiNHJf7Z/PHgn/i4o1R+LczeMDwvDVUwoqOg==
X-Received: by 2002:a05:6122:2887:b0:55b:305b:4e3e with SMTP id 71dfb90a1353d-56347ffb9edmr5814824e0c.20.1768238076243;
        Mon, 12 Jan 2026 09:14:36 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56374ba06efsm7016541e0c.11.2026.01.12.09.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 09:14:35 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5f4bfd8b-8699-4bef-bf49-f29965e95ca4@redhat.com>
Date: Mon, 12 Jan 2026 12:14:30 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
To: Thomas Gleixner <tglx@kernel.org>, Waiman Long <llong@redhat.com>,
 Marc Zyngier <maz@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260107215353.75612-1-longman@redhat.com>
 <864iowmrx6.wl-maz@kernel.org> <87ms2nsqju.ffs@tglx>
 <86wm1qlq7l.wl-maz@kernel.org> <87ecnwij44.ffs@tglx>
 <86v7h8l9ht.wl-maz@kernel.org>
 <40cec799-f363-4642-969b-24f5a2d56dfb@redhat.com> <87cy3eg94y.ffs@tglx>
In-Reply-To: <87cy3eg94y.ffs@tglx>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KWlDRfPV-S1prZm77O3oBijSzqD8rz9A-tsDy0uPY0c_1768238077
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/12/26 10:09 AM, Thomas Gleixner wrote:
> On Sun, Jan 11 2026 at 18:02, Waiman Long wrote:
>> On 1/11/26 5:38 AM, Marc Zyngier wrote:
>>>> Also that patch seems to be incomplete because there is another
>>>> allocation further down in allocate_vpe_l1_table()....
>>> Yeah, I wondered why page allocation wasn't affected by this issue,
>>> but didn't try to find out.
>> The use of GFP_ATOMIC flag in the page allocation request may help it to
>> dip into the reserved area and avoid taking any spinlock. In my own
>> test, just removing the kzalloc() call is enough to avoid any invalid
>> context warning. In the page allocation code, there is a zone lock and a
>> per_cpu_pages lock. They were not acquired in my particular test case,
>> though further investigation may be needed to make sure it is really safe.
> They might be acquired though. Only alloc_pages_nolock() guarantees that
> no lock is taken IIRC.

Thanks for the suggestion. I will look into using that for page 
allocation. I had actually attempt to use kmalloc_nolock() to replace 
kzalloc() initially. Even though it removed the call to rmqueue(), but 
there were other spinlocks in the slub code that were still being 
acquired like the local_lock() or the spinlock in the get_random() code. 
So I gave up using that. Anyway, kmalloc_nolock() doesn't seem to be 
fully working yet.

Cheers,
Longman

