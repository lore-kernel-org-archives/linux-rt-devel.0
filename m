Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A49CA64
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jan 2025 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746692; cv=none; b=deiIf4Rbdenvn2VLGETb3RC99dLWHnrRsxyNrX/MPgPjDt/N2IYhOnrpcqmwf/ixuv6sMrXrfjSScuWvU7fYPKHhx9ncoDDm229otRzvOP/EUJLJJ8vpbOQuRhahLjU6o167fm3G4CyoSVEFvpg3uOUHr2CLFRTnW/vC2wWZY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746692; c=relaxed/simple;
	bh=2YPGnFj6B92Yo1I+/HWSE+MhySxUj8XZk8gfaUqVwGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRjjU9C4tnKqb4JXBo7HCtmvmItY/mlwPbHqkmXQlUl60T75FBzZP78GDh4K6qXw3oIsNzigUUlAHP2lYzMuNU4ExY/d64YKONT2hFE6QBdK+vPvOv0TPsUrVM8u27BIe1z9KUAAijL6p+vf4sdpHEgKdDvFOWSi422fPuhID9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5kRGimh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5kRGimh"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab633d9582aso425692466b.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jan 2025 11:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737746689; x=1738351489; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YPGnFj6B92Yo1I+/HWSE+MhySxUj8XZk8gfaUqVwGs=;
        b=l5kRGimhTR/zfcdjhMPYduREqjnHhpYuu9oU8JEIu04efWMcmUp+qu0Umhg2XwVS4n
         fOY7OHT5wuibNsqcnM5Ua7UE9CTYdiSIU5xScSqmi8mcUnH1FIrOZfQmP0WcXsK2l0Wg
         BjEvLf4kjnKBW9AgMMaGDUS6ulokDQe4qhTHt4JO5IZIzUTuvMsNG/p9M+YePhveDcK/
         h+UZbXzU8qcI20O3hlbj7bb4usqmUCYvj8ZYVQVP5JcKcuN3Tg9cdE1JWJhYy5VunvYE
         pNOskR9e6AidhUkvW0YgRksx0WdaLizmJFqLcbofMWpmL7kucxHCmHxem1Q8RW5eiQgS
         vsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737746689; x=1738351489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YPGnFj6B92Yo1I+/HWSE+MhySxUj8XZk8gfaUqVwGs=;
        b=BBkH5VMjFlmNCFciA7OBaJRDX/xJc3PzDZ7emAPCDPph9+uUkshidKlD6NYMRYSHHQ
         mEwyWnbusNS2WJXnq2lwPM8hPW6bnbzDL2zAc+Y7EDsH/Ve584XNukmlOZITyMZ6pB/r
         uPSrTpwt2FSTfuT2Lkr60vF4KYcAe13MsCsnvqpYI6rMhdYerThd7bmQzYc/q549CUDP
         orvj2so0B9hcKrCcSF4be0Nf2slAB+0rIqq4zyqJ5MpNG8YRk1JNY2C6ln9tifmDHqpk
         Co3ajOq/XDSYoA0C90Y72oVF60Z7iWIYJHu9yUSQEa1vCRtBB9JUP2CcW/dHK4oLlpi5
         PS+A==
X-Forwarded-Encrypted: i=1; AJvYcCVMLlcaSa47qN9zOwTAI1rhx2X0apeLFkFwzAg8umr8rmdQHGRy/P5hPkC1xexhNiSWzvzDB3m4jJTCalb8cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxu/gyEFVzMXdSbNUxKFwvzRd9kMQ15ZAes9NxV22p2o04xVHMe
	MFjUjjwEv/BTXxBfC7FEXwJbRCo0vvkXAqJdKLosthu5bJdAhgxCFsoCnBGqfSLPUjVqLuTgS5B
	f4A7RqDLqOjNYOHAzjIUg92/BqLtnOFz3Rkg=
X-Gm-Gg: ASbGncvrEPXHsVcx1i6IxY4c8KEYucHmnP5ywaaxJIVH3czkykqs1VbBUJ72LRV9KjE
	8sTNp236ujdg65YkpXl233Y8KfGvSy1tO4Wa3q1p0usthEaQLUmbhUYak2hBXkJh8YO2B8rl0pG
	as72EaJDTBBSJoPg==
X-Google-Smtp-Source: AGHT+IGBD/edOEN6KzHRzja4foD1hqmFH7HTb/atHaJwpqUgCPu3+MNZ734edIJ5FK3zFdZbEn2ARDEtRhDJUh1g1HM=
X-Received: by 2002:a17:907:968a:b0:aa6:9e0f:d985 with SMTP id
 a640c23a62f3a-ab38b44e2a1mr3194933866b.35.1737746689184; Fri, 24 Jan 2025
 11:24:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250124185923.3610964-1-longman@redhat.com>
In-Reply-To: <20250124185923.3610964-1-longman@redhat.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 24 Jan 2025 11:24:36 -0800
X-Gm-Features: AWEUYZmuLkwID7kxWpPrcvp6GCF5L8mjDODzdEPwk3ii49Kru4qOLs_Ezx5Llo4
Message-ID: <CANDhNCr-3Pe2Cp9gjHLw1o=OHfPr0X7H+L6_rdGXQ-1pwc0+JA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clocksource: Use pr_info() for "Checking clocksource
 synchronization" message
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Feng Tang <feng.tang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 10:59=E2=80=AFAM Waiman Long <longman@redhat.com> w=
rote:
>
> The "Checking clocksource synchronization" message is normally printed
> when clocksource_verify_percpu() is called for a given clocksource if
> both the CLOCK_SOURCE_UNSTABLE and CLOCK_SOURCE_VERIFY_PERCPU flags
> are set. It is an informational message and so pr_info() should be used
> instead of pr_warn().
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: John Stultz <jstultz@google.com>

Thanks for sending this!
-john
