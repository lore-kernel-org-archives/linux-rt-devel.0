Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51D2620D1
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Apr 2025 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396245; cv=none; b=rcZ0Mf8gEWQD9HuQQNHNIF3FtKaf6suA5vBznTDFvfK9Qnd7pZ5KQ08XSmnMohGydW2a6ql2yekbWXDweKJTZpoSxm0Ry1lJWgXoTVw22vUAfllJfGzk8wiulYvLf/7u1TJdTBGLWJOfvgUvNkImIk+tHGhcVy+NHbxeIdfRG+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396245; c=relaxed/simple;
	bh=gbIjlJ4/bbqhbywHWi3G5k1aJY9GGtE24f8qSVkHBcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jc7r3c83o79skOxDnGdzPr/70YzuoAX2T3hiAyFmANFPF2Zjz5j7VjK89o305ExDUkyG9/3gV+6DREJPW97kpjZTxidugtXl3Al4+uGoEw5dtCrbX3BUGTFsX34CIIvNQFeI2HTZzPA8rRZR/Qyor31vMc6CLL6W/CZkSzYxeAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sl+U+9/9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sl+U+9/9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744396242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hRteb3aRXSBlgcZhgi2F2fUtSDh4vvSsqZj42m4O6k=;
	b=Sl+U+9/9owbqlUydWXaqcBio2Y2XoZ+M9/T8jWKCynt0jNSrnIOcl07xuClfC79tJFCGL3
	u0AcahGRyHsRElgKW7LUB9YwTwNhtlHhR1FdVc+yWaGhQK9aFG3YE/eoImMX7l9MxtTSJI
	AmydZDJa2VGiah9Uyhp3stQffJbdPoM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-F4kPHAXkM2quf_mD16ljOw-1; Fri, 11 Apr 2025 14:30:41 -0400
X-MC-Unique: F4kPHAXkM2quf_mD16ljOw-1
X-Mimecast-MFC-AGG-ID: F4kPHAXkM2quf_mD16ljOw_1744396241
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6ed0526b507so37057696d6.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 11 Apr 2025 11:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744396241; x=1745001041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hRteb3aRXSBlgcZhgi2F2fUtSDh4vvSsqZj42m4O6k=;
        b=GExE3za3/rJbUGMi+BFVQgsUptT6edhMqEl7RK7S6PHrwhfxvNjsj4PERaLI8fsnxw
         J3Jz9jwyw3fastftJsWlp8C945yKbENplGaGSucqot2DE6A/yv3f5DFp04TMCEXLmAzX
         dqD7j1xBxrsyAHqBA1Cv8MyGgO8nyvI363qbeEJvpKCnlG69NSOzC+tJrwAUWdLM42ZU
         eUAfOWZNw3ervaBUxXiI9v7lCRHFEHUE/EHtpf+bf1iLGYlwRFghRyrASnnYWV5FIxKM
         LAHjjTEBlTl3mdUZ6+IxPyDj2ZfV9c9YaNO3laWqEkhPGSNcZRUvwnGTltavtFx/OES7
         pXbg==
X-Forwarded-Encrypted: i=1; AJvYcCVFgKXVsX2a4zHR1+nzwBV7JuzuJ5JJhWupd3GxTNVP0ghrExLX2EgUqmfucJQMFlyNK8q8oDzHNWunlovPIA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8wNTk/5j4mEN6RY7RzTjGkh/MWvE6pz8B7Iu0YfV3Yy/vNm/6
	FsPfpf59QDfIabPeo4WJi+DuZLUo8XO18a5krzX7MFE/IjLyZkqFHRZqqAKMpgOnu2Q75Sie8X5
	uTcTRinTGAJQIqmGB3WczqesruqC9oDN7Ju529S04MXZUgRSusN9ffnOp5LM2dwNl
X-Gm-Gg: ASbGncvXcL6MfxrhYVJgz8pC4Q8objONR0sxXWPWP1Z4E9GfxFuGbqzMSks831g8KHV
	fhDwp+Ey890Z4TggHmNtYE93oIbR8X9h5CO0hLOASqJVk9XcD3dSwx5NtwBAqJtQADa6wX9N2lc
	7fX1tWP7Z3p0317CBrVaZc9vCIlHAonK+9FE+QTqhOzlIjZusP3YcPWVHtVGY/+XlFLhOGvtm0W
	+8oWKCvUgOHrB7NgrrclgbSDDpwd3v38ITDOx2zPPUsSmCE2o2Hr3AybRnghIJ6rvuYukLdR3qL
	hA2xFvAMKhifHmvcek1/Qtf/cb4WIbdPEal8h+fbaySBXEcc/x2fDPQ=
X-Received: by 2002:a05:6214:1d28:b0:6e8:9dd7:dfd0 with SMTP id 6a1803df08f44-6f23f188908mr52497406d6.44.1744396240840;
        Fri, 11 Apr 2025 11:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGTdRAZGTWxZjNDqvRXfFHjzIuclHnT9UwsGZfzm19ZI8mK/0p0p6x/jTN+uifKPieH9BXXA==
X-Received: by 2002:a05:6214:1d28:b0:6e8:9dd7:dfd0 with SMTP id 6a1803df08f44-6f23f188908mr52496946d6.44.1744396240449;
        Fri, 11 Apr 2025 11:30:40 -0700 (PDT)
Received: from localhost (pool-100-17-21-114.bstnma.fios.verizon.net. [100.17.21.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de837f9dsm40270486d6.0.2025.04.11.11.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 11:30:39 -0700 (PDT)
Date: Fri, 11 Apr 2025 14:30:38 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <zahvxexq572ud7p5nlbtty3attjn7h7fmlujhxxpdgsj346tpg@u3zqnfvrnh5k>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
 <20250409131444.9K2lwziT@linutronix.de>
 <4qyflnhrml2gvnvtguj5ee7ewrz3ejhgdb2lfihifzjscc5orh@6ah6qxppgk5n>
 <20250409142510.PIlMaZhX@linutronix.de>
 <43hey3rnt7ytbuu4rapcr2p7wlww7x2jtafnm45ihazkrylmij@n4p4tdy3x2de>
 <20250411-abgetan-zumachen-ada00fc3770c@brauner>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250411-abgetan-zumachen-ada00fc3770c@brauner>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TxA3BXy3S0xz9PKrl_-1Lih5AKMM_WDDXWWVFQyYPtE_1744396241
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2025 at 05:17:25PM +0200, Christian Brauner wrote:
> > With this, I have applied your patch for the following discussion and
> > down thread. Happy to send a v5, should this patch be deemed worth
> > pursuing.
> 
> I'll just switch to system_unbound_wq and there's no need to resend for
> now. If the numbers somehow change significantly due to that change just
> mention that. Thanks.
> 

Thank you, I do not see a significant change in the numbers with
system_unbound_wq compared to system_wq.

Best,

-- 
Eric Chanudet

