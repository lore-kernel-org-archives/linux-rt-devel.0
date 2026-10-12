Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509483D5229
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832145; cv=none; b=RAqm6gDZXAhml+KI8OkSdw7RqcCqhQlqudMDvFeYceYWL6LBiUItJ/p9LR3CL4zht2lZyXny0APZi5h2MlUWZfGLhS2necf4t3hvUKOx8KP6kWhbfnp+nYQh49MRIQVFteNKaPYM+eGen0lBA4YpcPJ5hh9RGrCTJh/HRMNgerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832145; c=relaxed/simple;
	bh=QaGsg8YHe+4kQJxQkKk1XH9DeZBJmhX14Rv5dC+iT5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGEnL6IUlYtqEGwy4r2DepwhinYVL/kEmiceQ9BpSezPFtlX16cjlzghSC+4atPDop4xzKwYsqMPd9O2WYn/APdSYbAcoaV7GiFst4jWqStWTQNEPXngTpDc8DpsBLvmDU0XLvpbxKTYIOYfXQwLD7pbvH3x2r0WHnvO/Q2GtrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pziZ7Bpx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pziZ7Bpx"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso19470085e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 12:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791832142; x=1792436942; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XYwwSnERvRQ2SylVNRBxQCfE31X9AnGYXZyWqtwRxqU=;
        b=pziZ7BpxWqKhz0nnahvUxRALti5ABYEf6xpkXNdkMVPe23FgImjL3ZpU/zXPy5ssPu
         S3d4HKPUKvxRpZs8azIAIbDjE+ZJuKHAS6AmZu3ted7Yv3ftepud2RVzb8BxeU8ClYt5
         L0FgZxorNpMj2eI/IDp5PjNPDIq1MM+iTShlt3Yw6jKI59PO27QSzzA+aBbpqyhoc3d5
         4bReKAEE6sWtjWYacCyH6ygHex/qA5UK75E/C9rB7juwWrFz7QUQdHMpbasu2cXezvNi
         0YQ6BqkWN+brGUONaqwIK2UmpuSa4mCUMuERn4dc8wdjtJbZofE5fqmPQyz7Px1yGByu
         uNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791832142; x=1792436942;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XYwwSnERvRQ2SylVNRBxQCfE31X9AnGYXZyWqtwRxqU=;
        b=MZWcEZfVRdS27ALC+5sF423w/5GqAzPpi/kQBKq1HMMNj/22hxHbwTMKje/xHelWnK
         32VxQXIcg4ewcpDUoy6Vjh1Wl/B75FK+YXt9sFlt6Hc1AOzTVEfOzl03GBchYzyfXDFN
         k7MeykD47V1RgDBeXbcVx4e9fCbbe4ZtJzZyBFWRixwaWJlLhTYne5jsOUUSYpqt3pbY
         bqJ4+ICNOy8ypexRiIDqWsX0iiabaPQQ7JAUe9pbkLsRgLP8gz+WcZUnZIweRgRHjl9A
         ynL4U9o3om2pIiqImuqaIXlMKBax6XYUim/TDuqUvPrpUpy2nzt46AEfSbbcZgLhQZ7i
         Bosw==
X-Forwarded-Encrypted: i=1; AKwUvBzPedZzPS83O5xPB5BRb0Ziberp+5nHYDQovMffXaVzDLYOpHtED82FK5aUe8BlHWfsQsV/kRWiaLBHIo1LeQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJdpzArpZbf/s52wppjKU00wPEcQNmkcPY1hlyxaxMzcOLs5Jbu
	FehE05+7MFLm0hC2/34sIMzvR9xIDceqOkYHnNwh370XTR3cMXpBGamt
X-Gm-Gg: AYBFou0XtoAnay+gaQnHFc6vPi8yy0ANl6SDbYajmZZvox/ReH6zXj2Zey5bXacPgMf
	ToL0PKwYN4Bl0AFd/tP2b1EbPGaFShsdzhbjyVR3R/qXdCUo+M7sfR+DTWu/Pddg2fVhk35RVbl
	3by0PfUkbTobAV6CMYi0TfmEs0KzHiEraMUc2752wRzmm2K2wTwhJNa9g6XZTx5oHUFj5jlRr+N
	4eMHDfjXRcJxa0dHfI5CV0htZ2LMqLfgNFW9JZ6wUBQyd+X+mtBIkVCOEqcpY0yv+iP4MMJ6q8P
	H9lCU7DgJRkO1iwfR0T4O1CR/6aBJuL+striUGpC4vnYwsdEM1VRX8rqSnvg9gRHQBmjtd64vhZ
	qc9xq4odCHxbx5c+UixIqmiS9Hvx6ZvN8p1vG6ntf8zvdzM5x+apoZ95ZQdZiWoSFZgBqF1jVUD
	/IA24P3p1HE3zyXjQz/SHETEdctiT60e3k64KrsH/rQujAosKya85OHz6rJ68MBgKWgCynckGix
	znf97Gt5s3+Y9FaEihgoCX3bcU+9EWxoAneXR3PjMYv1WmcJKvSSMYSdDN/TKSHVtMCum5uzkHx
	ODjFq1AEx7LdCEijXTZbw+R7wQG8E6cbdU2OE1zRDqiw/8nrmyanBQ2SqKzZUW6y5lQXobuX
X-Received: by 2002:a05:600c:8519:b0:49d:4ef:bf70 with SMTP id 5b1f17b1804b1-4a18e4a16femr188375425e9.10.1791832141574;
        Mon, 12 Oct 2026 12:09:01 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a8ab-0f01-016a-c770-797f-eaee.310.pool.telefonica.de. [2a02:3100:a8ab:f01:16a:c770:797f:eaee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f249692sm200105015e9.3.2026.10.12.12.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 12:09:00 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:08:58 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: Re: [PATCH v6] softirq: Preserve interrupt context during IRQ exit
Message-ID: <as0wCemtoR7p4S7-@gmail.com>
References: <20261011060742.30584-1-kmehltretter@gmail.com>
 <17377421-38AC-4453-B6CE-A4854ED597E6@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17377421-38AC-4453-B6CE-A4854ED597E6@mainlining.org>

Hi Bradley,

On Sun, Oct 11, 2026 at 10:31:04AM +0100, Bradley Morgan wrote:
> >Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >Link: https://lore.kernel.org/r/20260813130826.GW687043@noisy.programming.kicks-ass.net
> >Assisted-by: LLM
> 
> Very beneficial change in my opinion, well, nothing looks inherently broken
> 
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> 

Thanks for reviewing this again.

I think the patch is in good shape now, and I've also done a lot of
testing.

Thanks,
Karl
