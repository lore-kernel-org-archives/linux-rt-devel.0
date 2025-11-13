Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7E3596FC
	for <linux-rt-devel@lists.linux.dev>; Thu, 13 Nov 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051748; cv=none; b=L4OgKaWQnk3hjqJHorXe0CYoMrfbxiTGKbRWIP1I9H8Xc15jF9MLUoGDCMG5KSIsDZt+M89cn8+rXNfy/OyducmRDa1o6q8V2HfRH7LWY8Wt4Mj7KgmXGPwYQgAwiZY+97qbiHBvga4+Sllcxn0+xzo88grvGE253TmoItln/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051748; c=relaxed/simple;
	bh=eji/SSOdXF8gy4QaZiEYeuMQSUOPDcJ453Mxlf4rTC0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F0WioqU1tkwBco0arZ5UUrzfNLvggbndP/0Skwd4SQDJdXqIK4LU1xDGS/nJoEAIfnGvBXtxTmS0w0ugApFSVQ+c+zxfpYSaZ4uGyIFsl8r6/Kqp5jbIKLP9bLQ96IjHEdHUL3KlX6rfXf871kFQ1DeOxrPOUqXe+/fpTwKOaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=et/RNcfO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="et/RNcfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763051745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT3IZeq6xh+hTw96O3g7ZfztMQ4cq03lu+gFuSu+QgM=;
	b=et/RNcfO2AlURiHs5hGIgcgc6B1Ft+XLu528/ApNORm/OpwhUSG5bLupkVT69YcyxgOE17
	THN5356SBYcvckbPnW1IXMjjdKOMaPQpWQUsvNgAre7VAy4gvSUCDIWUuYdhJI6pwsw8rI
	rVj+iAepvWbsaW7d0UDnD6dBAz7hnW8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-Fhih13uJPYizbB2TORO1HA-1; Thu, 13 Nov 2025 11:35:44 -0500
X-MC-Unique: Fhih13uJPYizbB2TORO1HA-1
X-Mimecast-MFC-AGG-ID: Fhih13uJPYizbB2TORO1HA_1763051744
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edb35b1147so26858001cf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 13 Nov 2025 08:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051744; x=1763656544;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OT3IZeq6xh+hTw96O3g7ZfztMQ4cq03lu+gFuSu+QgM=;
        b=c5vfuYjfasMTiv6YM+CBMHMN2n0IVpgGNeYEBY4hh+XqjsshJ9LbUFNMOL0I+9z5o5
         a1fyAi/MdaKxJduMuNBCcqpOwZGn56nchDftVg7MaUnJIDrKq4YP7LYZ2XQ8XSr422PL
         hF4WOPEJPPSY4XbAMJlKdYSUJdiQo4F1e9WJ5I9UiXHnKnYRss0BUctRVDXg9qdijPIO
         pKg2UnGOwgMSJTZBVXzZtg94k5Rrgv4Teb+v2sOiw6XcFU/Re/KKgRXrLLUXHDB2XTiG
         1TzuMXAozqca9zI/W6kSKpSTb/N/FWESJMWoz/5tKsdFMQjK67rvtJ5mQjTXJ2cPsTK+
         bByQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr8CEzhR+rpckVu2Z2MYOXWHvdE3OreTJTkAHcr3K6O47xCtHoBzloO3m86F9eFwQzB9vC+eWs2U1aidNX2g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+GfDOcHJ9IPn2OXGhXBHUHhh6fW+QG46GqYc410Dgdr+HeSbj
	NAZL+DfL8ptJq1nwuihQ5CQFH2ERA8C2Uq1JndOW2hzRydQi9cKjIoBFgKWth4rEk+M4u2ve7T+
	nbv2HbR7kuw/dKC3TNprAO3e4+w9tKbSOdapxOOF7JQrEoJCYad7xMyQuloxfnEgLE+NU
X-Gm-Gg: ASbGncswJhj20gTZ776QFIl+rQRyu6owEnTiYFJzbvpny3q4NfBOFCDvg5gldO/HAi+
	222D766Rxyp7Ny9rBYuXdSZvZn3JK/rRKmz5X62OHdlTULgzJzxxReEX6gsze4PgV8MHw+cHvQu
	/wDLYQMuSHi5NVFIjXswGUg/nUo0NToTktejgwe6tQpaBcqHG8DShQaTpvt0Snx82ke82koDz95
	xiNSBljaHYKRimeIN48OlCtya62PiHaApRhdukPhfc5MXcvy409VaKC2BHwdNP2R9zTSnIqNOSu
	CPE9nDMDGAHmiROLFMzcVnQijhlFg9mx+faJdzm6FwiHAEjqCZMCbLY1epJ2tTXYBb4Cd4z2guX
	nTT4cOq5aErfrsWnw1Y2EGzL2P7rU6OWdRxqNnzN6Ly2PWw==
X-Received: by 2002:ac8:5a8e:0:b0:4eb:a82b:bc2e with SMTP id d75a77b69052e-4edf211b77amr3265401cf.58.1763051743734;
        Thu, 13 Nov 2025 08:35:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQFpx7ltJXzQEzs/abe+1AxOqVQWZvjF0Ua76N5ThbYdIc+i95x5FX7vaZTJCOKsnBikyGYQ==
X-Received: by 2002:ac8:5a8e:0:b0:4eb:a82b:bc2e with SMTP id d75a77b69052e-4edf211b77amr3264811cf.58.1763051743138;
        Thu, 13 Nov 2025 08:35:43 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede87eed39sm14709671cf.24.2025.11.13.08.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 08:35:42 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <da750417-948c-4968-bdb3-9fd267fb9c10@redhat.com>
Date: Thu, 13 Nov 2025 11:35:41 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH] cgroup/cpuset: Make callback_lock a
 raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Chen Ridong <chenridong@huawei.com>,
 Pingfan Liu <piliu@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
References: <20251112035759.1162541-1-longman@redhat.com>
 <20251112085124.O5dlZ8Og@linutronix.de>
 <318f1024-ba7a-4d88-aac5-af9040c31021@redhat.com>
 <20251113075356.Ix4N-p8X@linutronix.de>
In-Reply-To: <20251113075356.Ix4N-p8X@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H-X8DD6lVCr02NInPGas3bloCttwlgiMU6wUPrIoo8s_1763051744
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/25 2:53 AM, Sebastian Andrzej Siewior wrote:
> On 2025-11-12 13:21:12 [-0500], Waiman Long wrote:
>> On 11/12/25 3:51 AM, Sebastian Andrzej Siewior wrote:
>>> On 2025-11-11 22:57:59 [-0500], Waiman Long wrote:
>>>> The callback_lock is a spinlock_t which is acquired either to read
>>>> a stable set of cpu or node masks or to modify those masks when
>>>> cpuset_mutex is also acquired. Sometime it may need to go up the
>>>> cgroup hierarchy while holding the lock to find the right set of masks
>>>> to use. Assuming that the depth of the cgroup hierarch is finite and
>>>> typically small, the lock hold time should be limited.
>>> We can't assume that, can we?
>> We can theoretically create a cgroup hierarchy with many levels, but no sane
>> users will actually do that. If this is a concern to you, I can certainly
>> drop this patch.
> Someone will think this is sane and will wonder. We usually don't impose
> limits but make sure things are preemptible so it does not matter.
>
>>>> Some externally callable cpuset APIs like cpuset_cpus_allowed() and
>>> cpuset_cpus_allowed() has three callers in kernel/sched/ and all use
>>> GFP_KERNEL shortly before invoking the function in question.
>> The current callers of these APIs are fine. What I am talking is about new
>> callers that may want to call them when holding a raw_spinlock_t.
> No, please don't proactive do these changes like this which are not
> fixes because something was/ is broken.

I posted this patch as a response to my review of Pingfan Liu's deadline 
scheduler patch as it need to call cpuset_cpus_allowed() to get a proper 
cpumask. However, there is an alternative way to solve this problem, so 
I am dropping this patch now. In the future, if there is a better use 
case that needs this change, I will push this patch again.

Thanks,
Longman

