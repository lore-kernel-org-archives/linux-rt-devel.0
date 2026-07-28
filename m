Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C63F412C
	for <linux-rt-devel@lists.linux.dev>; Tue, 28 Jul 2026 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785232238; cv=none; b=IZtfxzR+WoohUDTYn9PtY/IiZS2tibNjSM4hMcZJ0A42ogQUsvSk02iq1r9Dr87ZDSxDEX9/XHyTpzb+bwr7PkYbYA2tpFdtZP9IwzQVPqlqIFOK735pDXewbA4nFrAAvLPA9DFKyXycZ+P+cBN0MHeMBrDSsCRepOpNArD9tkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785232238; c=relaxed/simple;
	bh=iKkwr8V1PuRndsb7cgQEaiCzyGc93W31tew9oyt9XRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DPXXknIPhTftXj2d812PkviKJ6ANjNJi4p5en7Jeytjkfx4Yg0dNMmMl48PTnWKKejgs3QcabVAZT4V/+v1+SmlEPb57IYjGiYl9VG19YKVyToaJ3LQ53of0p8WW40rvi4RxXCv9CfQVsnuKbBufNRIAXNVAGPItZ84EuyB+agQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkAHMNdr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkAHMNdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785232236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+dMiX263jf+8Bae1dw+OAYWda9quJsqvCsepo8Mcbw=;
	b=hkAHMNdrV9zgEmveMpYrAQupu9xOzctunByLSbuccbnq5jRM03bMopUtJQJQ6FnAnGRlas
	LUzU7gS5waLsujpkCyHcmsGgQTin6SyhqTLbp7F4fWZ6esyQDTI2uW0JgP+kNGNwQIbj50
	5ER5KZa2cL4+v5WMqrGVMerkVDUrWlc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-Iq27dMIQNIeCVpF9k_4Edw-1; Tue, 28 Jul 2026 05:50:34 -0400
X-MC-Unique: Iq27dMIQNIeCVpF9k_4Edw-1
X-Mimecast-MFC-AGG-ID: Iq27dMIQNIeCVpF9k_4Edw_1785232233
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49554715277so36167475e9.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 28 Jul 2026 02:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785232233; x=1785837033;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4+dMiX263jf+8Bae1dw+OAYWda9quJsqvCsepo8Mcbw=;
        b=g99D1Jw0x63Yfd2BYrgkHERNGwpvV0/jGRW4xyQFY9598KVYKxmcR91ko8kRSN4MNR
         Lynr7Wh9GOY8XKuLW25dlUxo6gx+MAt236t1MDNyrY3hyuhNq089Rp2frdd7Hs/pJ91D
         ZJ6gBpxohfAm2scpEY1e+eFBFkOKtK9KGSDPgqthNUNanpktMp5ojb9pTdyQ6s7VNxw8
         p2GRgDP/QhJjm9i9DFbfcK20KihWGrfDuXf8T4oAatdx5vtHFaRN8vdrlZCdX/8QLdyQ
         P+ETPteUejvi9rh3UnBpVhYm7KepRi+xLyP0rSwPemuYvWEb7TLPSBW1igWOybsrTg0k
         5qeA==
X-Forwarded-Encrypted: i=1; AHgh+RqsbQfH8g009rs7Q2Q10tdmFu20mfNjpIfclfy2byZZWZgaL2CFOe+deQju1tRAhaJedcC3Ar9Et8nEwVtHAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YycJskl39/IzKwYylHVid3vDHpmlFmpUHucmDTowW0VgKdmivtY
	PZjFQ5UbRuYfILb+qPk9VkQQC5x1+ehY2E6j0jFzYfIRCMmlVK8zxY5OvEfY+8f1x0c3z2KzPUt
	7xJbsr6qs28YLw6+K4H9syIGCTdfMg1v9ZVGZPZGcCPNcLWB2zeFpodb7Wu7KvQx2Yup7
X-Gm-Gg: AR+sD122ATNr1xXuo3+NE+NoRE2SChiLULo+5Pf0YOO0wVDcLrQ8IRyUVA8H6MopRHK
	nXscYXcJVGI4riqQm/6zfg7/cd6C1HspaPDi5HMW3YJrQsYRjxmQ6iX/8y9blprYbgTBdIO5JYm
	xAyzt+f2gcPnrNKNvnAazvPBEjXJcpNXZXTf3L0reHB6uTGHJOTn0Jud9AEiOlqrnaZhyzomoWU
	QdhwgItRZXU/NFQA1JsLeJ/I9koUIQjmSx97Hg2denf48p55j/LUBDAsD+WjBAz5zEVnd2ehlHY
	BhUhpJ8rlxtWBQ0XXEzdG2pI0t9WLrLrAnKD5YkFMKIu670BFdSYnvDQbEtlt6kmeSMpmSpZ0FM
	LP6Rt8rfCsD2nvWDpFZpsfg18t86xuHKjzUq4mzY8XBT4sbyChXD6BAzLMVbA0sZAHkKK6AOguY
	7xqQ==
X-Received: by 2002:a05:600c:8214:b0:495:5cda:52ec with SMTP id 5b1f17b1804b1-496c643b0f5mr17224455e9.16.1785232233337;
        Tue, 28 Jul 2026 02:50:33 -0700 (PDT)
X-Received: by 2002:a05:600c:8214:b0:495:5cda:52ec with SMTP id 5b1f17b1804b1-496c643b0f5mr17224185e9.16.1785232232921;
        Tue, 28 Jul 2026 02:50:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531afsm63156402f8f.24.2026.07.28.02.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 02:50:32 -0700 (PDT)
Message-ID: <e9709a13-9fd9-4ee3-88b0-9cc56a1ca07c@redhat.com>
Date: Tue, 28 Jul 2026 11:50:31 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] af_unix: Schedule the garbage collector
 at task exit
To: Nam Cao <namcao@linutronix.de>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <cover.1784712370.git.namcao@linutronix.de>
 <ba4ed2717e5225b7b77ef928fb97ee5544632811.1784712370.git.namcao@linutronix.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ba4ed2717e5225b7b77ef928fb97ee5544632811.1784712370.git.namcao@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qbSutT4GiJ-Fc9v0Ui75A8VnjRZmOaWSXVOefgvlnKc_1785232233
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 11:31 AM, Nam Cao wrote:
> When a task exits while still having dead cyclic reference AF_UNIX sockets,
> those sockets stay behind indefinitely until the garbage collector gets
> scheduled by an unrelated reason. This can be observed with the program
> below.
> 
> Resolve this issue by scheduling the garbage collector during task exit,
> after the task's file descriptors have been closed.
> 
>  #include <sys/mount.h>
>  #include <sys/socket.h>
>  #include <sys/un.h>
>  #include <sys/wait.h>
> 
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> 
> static int send_fd(int unix_fd, int fd)
> {
>         struct msghdr msgh;
>         struct cmsghdr *cmsg;
>         char buf[CMSG_SPACE(sizeof(fd))];
> 
>         memset(&msgh, 0, sizeof(msgh));
> 
>         memset(buf, 0, sizeof(buf));
>         msgh.msg_control = buf;
>         msgh.msg_controllen = sizeof(buf);
> 
>         cmsg = CMSG_FIRSTHDR(&msgh);
>         cmsg->cmsg_len = CMSG_LEN(sizeof(fd));
>         cmsg->cmsg_level = SOL_SOCKET;
>         cmsg->cmsg_type = SCM_RIGHTS;
> 
>         msgh.msg_controllen = cmsg->cmsg_len;
> 
>         memcpy(CMSG_DATA(cmsg), &fd, sizeof(fd));
>         return sendmsg(unix_fd, &msgh, 0);
> }
> 
> int main(int argc, char *argv[])
> {
> 	int fd[2];
> 	int i;
> 
> 	for (int n = 0; n < 100; ++n) {
> 		if (socketpair(PF_UNIX, SOCK_SEQPACKET, 0, fd) == -1)
> 			goto out_error;
> 
> 		for (i = 0; i < 100; ++i) {
> 			if (send_fd(fd[0], fd[0]) == -1)
> 				goto out_error;
> 
> 			if (send_fd(fd[1], fd[1]) == -1)
> 				goto out_error;
> 		}
> 	}
> 
> 	return 0;
> 
> out_error:
> 	fprintf(stderr, "error: %s\n", strerror(errno));
> }
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  include/net/af_unix.h | 5 +++++
>  kernel/exit.c         | 7 +++++++
>  net/unix/af_unix.h    | 1 -
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 34f53dde65ce..686f6f1d1c21 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -14,11 +14,16 @@
>  
>  #if IS_ENABLED(CONFIG_UNIX)
>  struct unix_sock *unix_get_socket(struct file *filp);
> +void unix_schedule_gc(struct user_struct *user);
>  #else
>  static inline struct unix_sock *unix_get_socket(struct file *filp)
>  {
>  	return NULL;
>  }
> +
> +static inline void unix_schedule_gc(struct user_struct *user)
> +{
> +}
>  #endif
>  
>  struct unix_address {
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 2c0b1c02920f..593ac4b0105f 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -71,6 +71,7 @@
>  #include <linux/unwind_deferred.h>
>  #include <linux/uaccess.h>
>  #include <linux/pidfs.h>
> +#include <net/af_unix.h>
>  
>  #include <uapi/linux/wait.h>
>  
> @@ -1009,6 +1010,12 @@ void __noreturn do_exit(long code)
>  	exit_task_work(tsk);
>  	exit_thread(tsk);
>  
> +	/*
> +	 * Must be after exit_files() and exit_task_work(tsk) to ensure that
> +	 * the task's AF_UNIX sockets have all been closed.
> +	 */
> +	unix_schedule_gc(NULL);

Sashiko noted this can cause relevant regressions:

https://sashiko.dev/#/patchset/cover.1784712370.git.namcao%40linutronix.de

Generally speaking hooking the unix GC at task exit time does not feel
right (layering violation). Perhaps scheduling the GC with a reasonable
timeout in unix_update_graph() would be better?

/P

