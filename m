Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017191;
	b=WkR/VhQbitRh8c2/dy2MqbOGJrXtqjlaUrZqhdZqKVRPoHSgia0uNvlu1SDVBWcF5zo4
	 ocsdK+hsfj2E2T1MlkT/8DZbUX+kzhnKX3F4bTHu12p21x4Zd8Il/Imlha5+EjKXk5/30
	 4XjF1UBb4uOmlzS/JT6jLHNYe+AK1kEpDn//TJVZQSpyWf/p76kmN9SgN3OOu0ETlnTnC
	 yh1jj0mJpkmqqQI0LLztf+YBRiuCYjtOlSQtfYfsXrAd4L+iQCmvf2NluRZNNxMt3OeZm
	 ozP9HBbDE3qClUbbBQDpPi/0t+S3XenEFL+l16RB75QAA5s4Ix/8ma/WPOnYYsTviOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017191;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=a85wi9zMKa3ITk5iiE5QycHbAdVE4Knzk7eFGcpu7xQ=;
	b=4CoILcCtSSVDFj3lZPP9571hIdBcJX6sxK3RAkcGizzrDhdpF7vihAjxyTN5pq9pxwYl
	 QxSO/UmrtUMn+Z+nSXKzXHbBzhXql6X8CQYH69SqL2UgGuyb5JOue8H6X5Z6CMvBUFjpA
	 NOJZPXwj4q0oJsFn+XTHe70z+aWz5Q60swppmObVl8b0GqPFSeISOOwAy6Qcp4zI77rxu
	 zSEhO29eY2n2r3cChmySxJ2LHC6VA0wcW4ag3lBWvpHnSeV1bLmZjY+zkiKBBYkn9e2E2
	 khtCxF4Wn+UWrKVvvMGOWxVU9MntKat5FC8sK909AoMOTdYe0DCSUFZwmthewLJMDrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GntU17sT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA2606A325
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 15:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9CA2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GntU17sT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795017190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a85wi9zMKa3ITk5iiE5QycHbAdVE4Knzk7eFGcpu7xQ=;
	b=GntU17sTwCEPiLDxsAqaaHOhZPXKJ7NLXyZMmlw3JzRCYtB0alzbzQZycSXIpOriK7VLHv
	t8hAaNRiK99MmrAtT7qhu3446lEtrafcw8570cbYm37YyB5TDVQWZnHfOAuKh2yrlzPW41
	PT4IZ5RMTOA4Sr8sl9fSZETH13RTWSk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-mkDUNy8AOfK3oiVxvmRZnw-1; Wed, 18 Nov 2026 10:53:08 -0500
X-MC-Unique: mkDUNy8AOfK3oiVxvmRZnw-1
X-Mimecast-MFC-AGG-ID: mkDUNy8AOfK3oiVxvmRZnw_1795017187
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4925ef75fc4so901929f8f.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 07:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017187; x=1795621987;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a85wi9zMKa3ITk5iiE5QycHbAdVE4Knzk7eFGcpu7xQ=;
        b=MaqorWrrN0ZDIednukMS2pnd/qQez2z2jM5qlTuGlUcRKrwnN7pUBdvsIxSZ4sNqbh
         Hu8+T4S62A0Ou8EPdpi4rxDrgug7OOPi2yJ9JBtPtkkS1PIrrpQhCCtqyaKVbiSxbQpK
         wGAeyaeZ0/Ca6v5STgAbu9LeE83x8F7N+dy8458vUGn9NTlM9QHB0lrYVsxRBPrlh1FT
         tFsYWE1ll0veV8/GsWEEpVvj9QliXmUTquXLDwQbVjX2IfyO5Kpa2a5H0jRJ/exd4Iov
         yAb4qsOwf7JoqiBi1UhfHTdsjE7xJKc48DGaQ/tR6VQOuNk7RFITfn6klxaYH8SkubPR
         nLhQ==
X-Forwarded-Encrypted: i=1; AL+hErGlQzL0uCCN18McPN7tX2cssnJmPNkErPbGrEooO0T8w4wt2hXzvCgsoXoKLxzQ5viFRELSPN09BCv7B2GfnQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9jq2w/LLOD+KnKWmMwZtpNLI10ZN+ZodM4JLqSNqiqdonUHduH
	axaDeCw/sXd2LG3TdZvNqJAIEl90dje2BBfHknHIXZdPgUCML/kBQ4d01t/jN7jP/OUOpZkkYQ5
	z7LURY5FWE26zjoUt6LSdcjx4wzF4ye92G/rnuGFAEflRZPRrwvGkaVppYW9S0JzEhu2l
X-Gm-Gg: AZFdTZcTUmjERIF8VtYKdqu7ppoZmxgsUYY0zov4OoHHaJz/LTuBmuo5vdLUlRXStjH
	/JTyKNDL7QTlYWE4S/Bx2cD9BjZhGWxj0bcqZZ6vNkqVJxrIUa4oKzBSdcUkOBZ2XWMfO8Pfxkv
	/ZqHuQ2xsmTiVgfH5tWzmTMaierxSGP5BxhsFyhfskLvd7OZM3TuINks8aL74l4fq46xRPciUAC
	TTcCZYn5a48LU3pzgtxy3V51CiJXugYBI4vIt5BWYw44M1Ms951tEWZ7kt0tKluOe1i6I7OgbDK
	gqHu3o8UGTfDtPgZiHxTvmJm8ZLD/Wxlo+xFKYTD+hSDYdpIJG2ZqHjVrRBSsHsVcPx9lg6//22
	JBtf8BXPuRbaNmkpWPyXQDjL8sZvMoxN5hOizyZFlW2J4XeAc1RJ1nAetj7ZZg4Jj/oMwJMiDvu
	2Nut0=
X-Received: by 2002:a05:6000:310e:b0:4a8:7115:fa0f with SMTP id ffacd0b85a97d-4a87115fd47mr1608217f8f.32.1795017187554;
        Wed, 18 Nov 2026 07:53:07 -0800 (PST)
X-Received: by 2002:a05:6000:310e:b0:4a8:7115:fa0f with SMTP id ffacd0b85a97d-4a87115fd47mr1608144f8f.32.1795017187160;
        Wed, 18 Nov 2026 07:53:07 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65683d5a2sm5699651f8f.43.2026.11.18.07.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:53:06 -0800 (PST)
Date: Wed, 18 Nov 2026 16:53:03 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v7 00/40] sched/deadline: bandwidth accounting fixes and
 selftests
Message-ID: <av3J3zMfkRplg-N4@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ns_xZ53mVvd_A4Xc6I9cgjhRV8KEfvVxhYH8LkXQwEs_1795017187
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 17/11/26 09:10, Mathieu Desnoyers wrote:
> Hi Ingo, Juri,
> 
> This series fixes 36 bugs of SCHED_DEADLINE. Most of them are in its

...

Thanks again for all the work on this!

So, I feel we are making progress, but the set keeps growing/changing.

While we spend more time on the "upper half" of it, would it maybe make
sense to split the lowest part so that foundation fixes can start to be
merged. I'm thinking 1-8, 10, 13, 14, 16, 20, 37 (37 is not a fix but
harmless). Not all associated test will pass of course, which is not
super nice, but we know they pass with the complete set and can maybe
come later.

Just a thought, happy to continue iterating over the complete set.

Thanks,
Juri

