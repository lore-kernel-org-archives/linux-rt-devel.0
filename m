Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20E280A5A
	for <linux-rt-devel@lists.linux.dev>; Wed, 23 Apr 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420697; cv=none; b=mJMeTmqkOIkkTVdYBjUL0E/dQTi8avTmb8wxpr4k5SFvgotpFeo27/8XnLc6SKHocOwlRwTxGIcuJ/rnsaBO79EqpGimUEAyjtnyYb+NBx0dgwZU7zv124wc9FEJsd3bxk0UR1h46IZJ969Ynl4bB8i7k4/qgkfxVckXFpT8/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420697; c=relaxed/simple;
	bh=4R6lj0hZ4/p7O8oGQyGh1YZI8vXp8HHuwSAXkKuPK68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jM/OAy5DRuqdhVsv2N8TO0uikFIrnjJ/FJmB2MTV4rdTeHbPeYF+6pbsqfTW+NgHaGtX2KpYEHDVMuxM3cxMPjXqYFvr6tNNzTyTvRKIi95RWp6qMUNNaWvpA7nXIyA0JrciFalXmVTPjtsJNkoCwldJKBnGqpRNALx9Y5pS1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzJNdRrx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzJNdRrx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745420694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/XwtWlQK2gWEuKfXA1Y/H+Qql53usM87hFbg/riAys=;
	b=bzJNdRrxI0Jt56JxlqzwQeMCn/wyOptXdaY7VWmu/gEhjQgEvS1sk41qZZFH3CveeDeSZR
	Myq1CZ5pBaMxvc95ov0yo3+uzSegXDsFsZCK4rVW6tKE/gxG6CAZgioQS0DLRJjEvzSz1b
	kz3TWwD4Clz5McijUjT+CXktXst6EE4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-mwwAd53yP7evhujeyJYuGA-1; Wed, 23 Apr 2025 11:04:53 -0400
X-MC-Unique: mwwAd53yP7evhujeyJYuGA-1
X-Mimecast-MFC-AGG-ID: mwwAd53yP7evhujeyJYuGA_1745420692
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8feffbe08so156960996d6.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 23 Apr 2025 08:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420692; x=1746025492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/XwtWlQK2gWEuKfXA1Y/H+Qql53usM87hFbg/riAys=;
        b=deqxaDAmt8k5kNQBDTypLcSLuNCqYM+wZ9uBUW5bsxCKjfsTdmWXeObhjoLfsf5lSi
         Mr0XDGGRUxqD5/38cXRWywJEWpsTopKbyrJ/Bg1p/+RDAHEkgGXhrEYapEzkIp+n+O+e
         wwILlfXoeinbThOA6dKkKjSJVu3G+ymWJVUI2RQxscvinE0nCnzwXjbikW/3TDtkZWGD
         9F48ssFp9AEj4WBoItjmCPqa/zLYNzoAHeFvfN0oRmuY+aXe0lESgn54KlEFvi92VJUR
         jKQlzKG6QeUMHQzrlN2eaui5yaLKUl8r4b/h4SABF4p5S55OwN1+0yK+w81o9pN5/wvo
         7/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVocVMolIkwAdmZxpP0P3l3PpU+q5Thm43qKwiouJpf6th0yUAZtHK4g59jjE6CzpQ4FTVKdg13LYV+Z1vDoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcIUnie8t+xkmmQuGgUg0r6z5NjaXms+nl4ATheSs75PNmeug0
	GlPnOWhVqY6uu/9uBk+zEXCr9rLjAapWkN2F7Vbe05sahFjmhytHD515vaMRdjfXqN4lrBS1lSD
	2UtTiuczPBt8FuTOGjKSXqoN9bMZ07x1AFGUmxnSEgE5sKEJgz0VzIgz4aEVVBVK5
X-Gm-Gg: ASbGnctOi22OF/wEqM44axShYexmycj/0yEtU2kjISBsHmBrLwgI9/OxRDaaUKzfZgj
	AuBLDliox7gLE/Tc3cAFTyeaYx/N7fbXhmZ67jiJDI9PQ1OkVLjtMH9Jh+fNati283L7ypB/8YK
	e9E2RCDOvat7IVRdC54DqVOy+3YUCy29L+iF4WQK9OOgpZSPt1RtCcm89aqdhtJgLeYxZzJ+Qzk
	civLl74ZPn0M+8nwXEGs9jiVMR0Yv3QJewtFNwCH6qWBLz+ZBXsy8utC2zs2sMizrY9bTz6L1+L
	ksty/otjc5sHNhvOcAQv9Xdr9vRRUgxTvhfLSCEXHQM9duHe1k2gVDM=
X-Received: by 2002:a05:6214:5085:b0:6eb:28e4:8519 with SMTP id 6a1803df08f44-6f2c4562ff4mr349522826d6.21.1745420691628;
        Wed, 23 Apr 2025 08:04:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIAe6YgRzYFI//AuYLkGgT9bMQm2RTQxu8bUNb2e6etKdith1hNCEE0IZQWqDOiU1oDePTvw==
X-Received: by 2002:a05:6214:5085:b0:6eb:28e4:8519 with SMTP id 6a1803df08f44-6f2c4562ff4mr349521466d6.21.1745420690350;
        Wed, 23 Apr 2025 08:04:50 -0700 (PDT)
Received: from localhost (pool-100-17-21-114.bstnma.fios.verizon.net. [100.17.21.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af5b28sm71585546d6.10.2025.04.23.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 08:04:49 -0700 (PDT)
Date: Wed, 23 Apr 2025 11:04:48 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <ubimdwyutm47mlmtn43mbobtnwaxkmuse3vpgosbsh4yd7f73t@bbt7az62ybbb>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250420055406.GS2023217@ZenIV>
 <fzqxqmlhild55m7lfrcdjikkuapi3hzulyt66d6xqdfhz3gjft@cimjdcqdc62n>
 <20250423021547.GD2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250423021547.GD2023217@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1mM5BSZ9pgYGaERrIwatEB7ZPMCZKUmn7GY5-cPGj3M_1745420692
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 23, 2025 at 03:15:47AM +0100, Al Viro wrote:
> On Tue, Apr 22, 2025 at 03:53:43PM -0400, Eric Chanudet wrote:
> 
> > I'm not quite following. With umount -l, I thought there is no guaranty
> > that the file-system is shutdown. Doesn't "shutdown -r now" already
> > risks loses without any of these changes today?
> 
> Busy filesystems might stay around after umount -l, for as long as they
> are busy.  I.e. if there's a process with cwd on one of the affected
> filesystems, it will remain active until that process chdirs away or
> gets killed, etc.  Assuming that your userland kills all processes before
> rebooting the kernel, everything ought to be shut down, TYVM...
> 
> If not for that, the damn thing would be impossible to use safely...
> 

Right, that ties up with Christian's earlier reply and was also stated
in 9ea459e110df ("delayed mntput") description.

Thanks for your patience and explanations.

-- 
Eric Chanudet

